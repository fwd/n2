
function send_with_pow() {

    # echo $1
    # echo $2
    # echo $3
    # echo $4
    # exit 0

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

    if [[ $1 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing To. Usage 'n2 send_with_pow [to] [amount] [from] [work]'"
        exit 0
    fi
    
    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Amount. Use 'all' to send entire balance."
        exit 0
    fi

    if [[ $3 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing From. Usage 'n2 send_with_pow [to] [amount] [from] [work]'"
        exit 0
    fi

    # if [[ $4 == "" ]]; then
    #     echo "${CYAN}Node${NC}: Missing Work. Usage 'n2 send_with_pow [to] [amount] [from] [work]'"
    #     exit 0
    # fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    if [[ "$2" == "all" ]]; then

  ACCOUNT=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$3",
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
        AMOUNT_FINAL=$2
    fi

    # TODO: Replace with something local...but what??
    AMOUNT_IN_RAW=$(curl -s "https://api.nano.to/convert/toRaw/$AMOUNT_FINAL" \
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
    "source": "$1",
    "destination": "$3",
    "amount": "$(jq -r '.value' <<< "$AMOUNT_IN_RAW")",
    "id": "$(uuidgen)",
    "work": "$4"
}
EOF
    ))

    echo $SEND_ATTEMPT

    exit 0
    
}


if [[ $1 == "send_with_pow" ]]; then
    cat <<EOF
$(send_with_pow $2 $3 $4 $5)
EOF
    exit 0
fi


