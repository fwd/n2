function local_send() {

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Username or Nano Address."
        exit 0
    fi
    
    if [[ $3 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing amount. Use 'all' to send entire balance."
        exit 0
    fi

    if [[ $4 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing source address."
        exit 0
    fi

    if [[ $(cat $DIR/.n2-wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2-wallet
    else
        WALLET_ID=$(cat $DIR/.n2-wallet)
    fi

    UUID=$(cat /proc/sys/kernel/random/uuid)

    # TODO: Replace... no bash BIG.JS
    AMOUNT_IN_RAW=$(curl -s "https://api.nano.to/convert/toRaw/$3" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    if [[ "$2" == *"nano_"* ]]; then
        DEST=$2
    else
        NAME_DEST=$(echo $2 | sed -e "s/\@//g")
        SRC_ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$NAME_DEST'"))' | jq '.[0]')
        DEST=$(jq -r '.address' <<< "$SRC_ACCOUNT")
    fi

    if [[ "$4" == *"nano_"* ]]; then
        SRC=$4
    else
        NAME_DEST=$(echo $4 | sed -e "s/\@//g")
        DEST_ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$NAME_DEST'"))' | jq '.[0]')
        SRC=$(jq -r '.address' <<< "$DEST_ACCOUNT")
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

    # echo "ACCOUNT", $ACCOUNT

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

    # echo "POW" $POW

    # exit 0

    # if [[ $(jq -r '.work' <<< "$POW") == "" ]]; then
    #     echo $POW
    #     echo
    #     echo "==============================="
    #     echo "       USED ALL CREDITS        "
    #     echo "==============================="
    #     echo "  Use 'n2 buy pow' or wait.    "
    #     echo "==============================="
    #     echo
    #     return
    # fi

    WORK=$(jq -r '.work' <<< "$POW")

    # echo "AMOUNT_IN_RAW" $AMOUNT_IN_RAW

    # exit 0
    
    echo "WORK" $WORK

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

    echo "SEND_ATTEMPT" $SEND_ATTEMPT

    exit 0

    if [[ $(jq -r '.block' <<< "$SEND_ATTEMPT") == "" ]]; then
        echo
        echo "================================"
        echo "             ERROR              "
        echo "================================"
        echo "$(jq -r '.error' <<< "$SEND_ATTEMPT") "
        echo "================================"
        echo
        exit 0
    fi

    echo "==============================="
    echo "         NANO RECEIPT          "
    echo "==============================="
    echo "AMOUNT: "$3
    echo "TO: "$DEST
    echo "FROM: "$SRC
    echo "BLOCK: "$(jq -r '.block' <<< "$SEND_ATTEMPT")
    echo "--------------------------------"
    echo "BROWSER: https://nanolooker.com/block/$(jq -r '.block' <<< "$SEND_ATTEMPT")"
    echo "==============================="

    exit 0
    
}


if [[ "$1" = "rpc" ]] || [[ "$1" = "--rpc" ]] || [[ "$1" = "curl" ]] || [[ "$1" = "--curl" ]] ; then

    curl -s "[::1]:7076" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{ "action": "$2", "json_block": "true" }
EOF
) | jq

    exit 0
fi

if [[ "$2" = "exec" ]] || [[ "$2" = "--exec" ]]; then
    docker exec -it nano-node /usr/bin/nano_node $1 $2 $3 $4
    exit 0
fi

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


if [[ $1 == "address" ]]; then

    SRC=$(nano-node /usr/bin/nano_node --wallet_list | grep 'nano_' | awk '{ print $NF}' | tr -d '\r')

    echo "asd"

    exit 

fi

if [[ $1 == "remove" ]] || [[ $1 == "rm" ]]; then

   if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Address to remove."
        exit 0
    fi

    if [[ $(cat $DIR/.n2-wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2-wallet
    else
        WALLET_ID=$(cat $DIR/.n2-wallet)
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

if [[ $1 == "list" ]] || [[ $1 == "ls" ]]; then

    if [[ $(cat $DIR/.n2-wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2-wallet
    else
        WALLET_ID=$(cat $DIR/.n2-wallet)
    fi

    accounts=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_list",
    "wallet": "$WALLET_ID",
    "json_block": "true"
}
EOF
    ))

    echo $(jq -r '.accounts' <<< "$accounts") 

    exit 0

fi

if [[ $1 == "wallet" ]]; then

    if [[ $(cat $DIR/.n2-wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2-wallet
    else
        WALLET_ID=$(cat $DIR/.n2-wallet)
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

    exit 

fi

if [[ $1 == "balance" ]] || [[ $1 == "account" ]]; then

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Username or Nano Address."
        exit 0
    fi

    if [[ "$2" == *"nano_"* ]]; then
        _ADDRESS=$2
    else
        _NAME=$(echo $2 | sed -e "s/\@//g")
        _ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$_NAME'"))' | jq '.[0]')
        _ADDRESS=$(jq -r '.address' <<< "$_ACCOUNT")
    fi

    ACCOUNT=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$_ADDRESS"
}
EOF
    ))

    echo $ACCOUNT

    exit 

fi


if [[ "$2" = "setup" ]] || [[ "$2" = "--setup" ]] || [[ "$2" = "install" ]]; then

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo ""
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "${CYAN}Node${NC}: You're on a Mac. OS not supported. Try a Cloud server running Ubuntu."
        sponsor
        exit 0
      # Mac OSX
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
      # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
      # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
      # I'm not sure this can happen.
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
      # ...
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
    else
       # Unknown.
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
    fi

    # Coming soon
    if [[ "$2" = "pow" ]] || [[ "$2" = "--pow" ]] || [[ "$2" = "pow-proxy" ]] || [[ "$2" = "pow-server" ]]; then
        read -p 'Setup Nano PoW Server: Enter 'y': ' YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            # @reboot ~/nano-work-server/target/release/nano-work-server --gpu 0:0
            # $DIR/nano-work-server/target/release/nano-work-server --cpu 2
            # $DIR/nano-work-server/target/release/nano-work-server --gpu 0:0
            exit 0
        fi
        echo "Canceled"
        exit 0
    fi

    # Sorta working
    if [[ "$2" = "gpu" ]] || [[ "$2" = "--gpu" ]]; then
        read -p 'Setup NVIDIA GPU. Enter 'y' to continue: ' YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            sudo apt-get purge nvidia*
            sudo ubuntu-drivers autoinstall
            exit 0
        fi
        echo "Canceled"
        exit 0
    fi

    read -p 'Attempt to setup a Nano Node: Enter 'y': ' YES
    if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
        # https://github.com/fwd/nano-docker
        curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
        # cd $DIR && git clone https://github.com/fwd/nano-docker.git
        # LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
        # cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
        exit 0
    fi
    echo "Canceled"
    exit 0

fi


