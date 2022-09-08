
function local_send() {

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL >> $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node not found.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Params. Usage 'n2 send [to] [amount] [from]'"
        exit 0
    fi
    
    if [[ $3 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Params. Use 'all' to send entire balance."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    UUID=$(uuidgen)
    # UUID=$(cat /proc/sys/kernel/random/uuid)

    accounts_on_file=$(get_accounts)

    if [[ -z "$4" ]] || [[ "$4" == "--json" ]]; then

        if [[ $(cat $DIR/.n2/main 2>/dev/null) == "" ]]; then
            SRC=$(jq '.accounts[0]' <<< "$accounts_on_file" | tr -d '"') 
            echo $SRC >> $DIR/.n2/main
        else
            SRC=$(cat $DIR/.n2/main)
        fi
        
    else

        if [ -n "$4" ] && [ "$4" -eq "$4" ] 2>/dev/null; then
           
            if [[ -z "$4" ]]; then
              ACCOUNT_INDEX="0"
            else
              ACCOUNT_INDEX=$(expr $4 - 1)
            fi

            SRC=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 

        else
            
            SRC=$4

        fi

        # TODO Code: Find item in JQ array via BASH. Why is it so hard?!

    fi

    if [[ "$3" == "all" ]]; then

  ACCOUNT=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$4",
    "representative": "true",
    "pending": "true",
    "receivable": "true"
}
EOF
  ))
        AMOUNT_FINAL_RAW=$(jq -r '.balance' <<< "$ACCOUNT")
        AMOUNT_FINAL_API=$(curl -s "https://api.nano.to/convert/fromRaw/$AMOUNT_FINAL_RAW" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)
        AMOUNT_FINAL=$(jq -r '.value' <<< "$AMOUNT_FINAL_API")
    else
        AMOUNT_FINAL=$3
    fi

    # TODO: Replace with something local...but what??
    AMOUNT_IN_RAW=$(curl -s "https://api.nano.to/convert/toRaw/$AMOUNT_FINAL" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
           
      if [[ -z "$2" ]]; then
        ACCOUNT_INDEX="0"
      else
        ACCOUNT_INDEX=$(expr $2 - 1)
      fi

      DEST=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 

    else
      
      # first_account=$2

        if [[ "$2" == *"nano_"* ]]; then
            DEST=$2
        else
            NAME_DEST=$(echo $2 | sed -e "s/\@//g")
            SRC_ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$NAME_DEST'"))' | jq '.[0]')
            DEST=$(jq -r '.address' <<< "$SRC_ACCOUNT")
        fi
        
    fi

    if [[ "$2" == "reps" ]] || [[ "$2" == "names" ]]; then

        REP_LIST=$(curl -s "https://api.nano.to/group/$2")

        readarray -t my_array < <(jq '.[]' <<< "$REP_LIST")

        COUNT=$(jq '.[] | length' <<< "$REP_LIST")
        AMOUNT_PER=$(awk "BEGIN { print $3 / $COUNT }")
        
        index=1

        for item in "${my_array[@]}"; do

            if [[ "$item" == *"nano_"* ]]; then
             
                if (( $(awk "BEGIN { print $3 < 0.01 }") == "1" )); then
                    # echo 
                    echo "${RED}Error:${NC} Amount '$3' is too low."
                    exit 0
                fi

    ACCOUNT=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$SRC"
}
EOF
    ))

    POW=$(curl -s '[::1]:7090' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "work_generate",
    "hash": "$(jq -r '.frontier' <<< "$ACCOUNT")"
}
EOF
    ))

    WORK=$(jq -r '.work' <<< "$POW")

    AMOUNT_IN_RAW=$(curl -s "https://api.nano.to/convert/toRaw/$AMOUNT_PER" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    SEND_ATTEMPT=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "send",
    "wallet": "$WALLET_ID",
    "source": "$SRC",
    "destination": "$(echo "$item" | tr -d '"')",
    "amount": "$(jq -r '.value' <<< "$AMOUNT_IN_RAW")",
    "id": "$(uuidgen)",
    "work": "$WORK"
}
EOF
    ))          
                # echo "Paid."

                sleep .5

                echo $SEND_ATTEMPT

                let "index++"

            fi

        done

        exit 0

    fi

    ACCOUNT=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$SRC"
}
EOF
    ))

    POW=$(curl -s '[::1]:7090' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "work_generate",
    "hash": "$(jq -r '.frontier' <<< "$ACCOUNT")"
}
EOF
    ))

    WORK=$(jq -r '.work' <<< "$POW")

    SEND_ATTEMPT=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "send",
    "wallet": "$WALLET_ID",
    "source": "$SRC",
    "destination": "$DEST",
    "amount": "$(jq -r '.value' <<< "$AMOUNT_IN_RAW")",
    "id": "$UUID",
    "work": "$WORK"
}
EOF
    ))

    if [[ "$(jq -r '.block' <<< "$SEND_ATTEMPT")" == "null" ]]; then
        # echo
        echo "================================"
        echo "             ${RED}ERROR${NC}              "
        echo "================================"
        echo "$(jq -r '.error' <<< "$SEND_ATTEMPT") "
        echo "================================"
        echo
        exit 0
    fi

    if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
        echo $SEND_ATTEMPT
        exit 0
    fi

    echo "==============================="
    echo "         ${GREEN}NANO RECEIPT${NC}          "
    echo "==============================="
    echo "${GREEN}AMOUNT${NC}: "$AMOUNT_FINAL
    echo "${GREEN}TO${NC}: "$DEST
    echo "${GREEN}FROM${NC}: "$SRC
    # echo "BLOCK: "$(jq -r '.block' <<< "$SEND_ATTEMPT")
    echo "--------------------------------"
    echo "https://nanolooker.com/block/$(jq -r '.block' <<< "$SEND_ATTEMPT")"
    echo "==============================="

    exit 0
    
}


if [[ "$1" = "--seed" ]] || [[ "$1" = "--secret" ]]; then
  WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}')
  SEED=$(docker exec -it nano-node /usr/bin/nano_node --wallet_decrypt_unsafe --wallet=$WALLET_ID | grep 'Seed' | awk '{ print $NF}' | tr -d '\r')
  echo $SEED
fi


if [[ $1 == "send" ]] || [[ $1 == "--send" ]] || [[ $1 == "-s" ]]; then
    cat <<EOF
$(local_send $1 $2 $3 $4)
EOF
    exit 0
fi

if [[ $1 == "remove" ]] || [[ $1 == "rm" ]]; then


    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL >> $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node not found.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Address to remove."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    REMOVE=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_remove",
    "wallet": "$WALLET_ID",
    "account": "$2"
}
EOF
    ))

    echo $REMOVE

    exit 0

fi


if [[ $1 == "wallet" ]]; then


    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL >> $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node not found.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    WALLET=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "wallet_info",
    "wallet": "$WALLET_ID",
    "json_block": "true"
}
EOF
    ))

    echo $WALLET

    exit 0

fi

if [[ $1 == "address" ]]; then

    print_address $2 $3

    exit 0

fi

if [[ $1 == "b" ]] || [[ $1 == "balance" ]] || [[ $1 == "account" ]]; then

    print_balance $2 $3 $4

    exit 0

fi

if [[ $1 == "clear-cache" ]]; then
    rm -rf "$DIR/.n2"
    echo "${RED}N2${NC}: Cache cleared."
    exit 0
fi

if [[ $1 == "set" ]] || [[ $1 == "--set" ]]  || [[ $1 == "config" ]]; then
    echo $3 > "$DIR/.n2/$2"
    exit 0
fi

if [[ $1 == "save" ]]; then
    if [[ $2 == "" ]]; then
        echo "${RED}Error${NC}: Missing Hash" 
        exit 0
    fi
    if [[ $3 == "" ]]; then
        echo "${RED}Error${NC}: Missing JSON Metadata" 
        exit 0
    fi
    if jq -e . >/dev/null 2>&1 <<<"$3"; then
        # mkdir -p $DIR/.n2/$2
        echo $3 > "$DIR/.n2/$2"
    else
        echo "Failed to parse JSON"
    fi
    exit 0
fi