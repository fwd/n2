function local_send() {

    if curl -s --fail -X POST '[::1]:7076'; then
        echo ""
    else
       echo "${CYAN}Cloud${NC}: No local Node found. Use 'n2 setup node' or use 'n2 cloud send'"
       exit 1
    fi;

    if [[ $2 == "" ]]; then
        echo "${CYAN}Cloud${NC}: Missing Username or Nano Address."
        exit 1
    fi
    
    if [[ $3 == "" ]]; then
        echo "${CYAN}Cloud${NC}: Missing amount. Use 'all' to send balance."
        exit 1
    fi

    WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )

    UUID=$(cat /proc/sys/kernel/random/uuid)

    AMOUNT_IN_RAW=$(curl -s "https://nano.to/cloud/convert/toRaw/$3" \
        -H "Accept: application/json" \
        -H "session: $(cat $DIR/.n2-session)" \
        -H "Content-Type:application/json" \
        --request GET)

    SRC=""
    DEST=""

    ACCOUNT=$(curl -s "https://nano.to/$SRC/account" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    POW=$(curl -s "https://nano.to/$(jq -r '.frontier' <<< "$ACCOUNT")/pow" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    if [[ $(jq -r '.error' <<< "$POW") == "429" ]]; then
        echo
        echo "==============================="
        echo "       USED ALL CREDITS        "
        echo "==============================="
        echo "  Use 'n2 buy pow' or wait.    "
        echo "==============================="
        echo
        return
    fi

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
    "json_block": "true",
    "work": "$WORK"
}
EOF
    ))

    if [[ $(jq -r '.block' <<< "$SEND_ATTEMPT") == "" ]]; then
        echo
        echo "================================"
        echo "             ERROR              "
        echo "================================"
        echo "$(jq -r '.error' <<< "$SEND_ATTEMPT") "
        echo "================================"
        echo
        exit 1
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

    exit 1
    
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

    exit 1
fi

if [[ "$2" = "exec" ]] || [[ "$2" = "--exec" ]]; then
    docker exec -it nano-node /usr/bin/nano_node $1 $2 $3 $4
    exit 1
fi

if [[ "$1" = "node" ]] && [[ "$2" = "--wallet" ]]; then
    docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}'
fi

if [[ "$1" = "--seed" ]] || [[ "$1" = "--secret" ]]; then
  WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}')
  SEED=$(docker exec -it nano-node /usr/bin/nano_node --wallet_decrypt_unsafe --wallet=$WALLET_ID | grep 'Seed' | awk '{ print $NF}' | tr -d '\r')
  echo $SEED
fi

if [[ "$1" = "favorites" ]] || [[ "$1" = "saved" ]]; then

    if [[ $(cat $DIR/.n2-favorites 2>/dev/null) == "" ]]; then
        echo "[{ \"hello\": \"world\"  }]" >> $DIR/.n2-favorites
    fi

    cat $DIR/.n2-favorites

    exit 1

fi

if [[ "$1" = "reset-saved" ]]; then
    rm $DIR/.n2-favorites
    echo "[]" >> $DIR/.n2-favorites
    exit 1
fi

if [[ "$1" = "save" ]] || [[ "$1" = "favorite" ]]; then

    if [[ $(cat $DIR/.n2-favorites 2>/dev/null) == "" ]]; then
        echo "[]" >> $DIR/.n2-favorites
    fi

    if [[ "$2" = "" ]]; then
        echo "${CYAN}Cloud${NC}: Missing Nano Address."
        exit 1
    fi

    if [[ "$3" = "" ]]; then
        echo "${CYAN}Cloud${NC}: Missing Nickname."
        exit 1
    fi

    SAVED="$(cat $DIR/.n2-favorites)" 
    rm $DIR/.n2-favorites 
    jq <<< "$SAVED" | jq ". + [ { \"name\": \"$1\", \"address\": \"$2\" } ]" >> $DIR/.n2-favorites 

    exit

fi


if [[ $1 == "send" ]] || [[ $1 == "--send" ]] || [[ $1 == "-s" ]]; then
    cat <<EOF
$(local_send $2 $3 $4)
EOF
    exit 1
fi


if [[ $1 == "balance" ]] || [[ $1 == "accounts" ]] || [[ $1 == "account" ]] || [[ $1 == "ls" ]]; then

    echo 
cat <<EOF
${GREEN}Local${NC}: N1: Wallet is in-development. 

Github: https://github.com/fwd/n2
Twitter: https://twitter.com/nano2dev
EOF

fi


if [[ "$2" = "setup" ]] || [[ "$2" = "--setup" ]] || [[ "$2" = "install" ]]; then

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo ""
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            echo "${CYAN}Cloud${NC}: You're on a Mac. OS not supported. Try a Cloud server running Ubuntu."
            sponsor
            exit 1
          # Mac OSX
        elif [[ "$OSTYPE" == "cygwin" ]]; then
            echo "${CYAN}Cloud${NC}: Operating system not supported."
            sponsor
            exit 1
          # POSIX compatibility layer and Linux environment emulation for Windows
        elif [[ "$OSTYPE" == "msys" ]]; then
            echo "${CYAN}Cloud${NC}: Operating system not supported."
            sponsor
            exit 1
          # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        elif [[ "$OSTYPE" == "win32" ]]; then
          # I'm not sure this can happen.
            echo "${CYAN}Cloud${NC}: Operating system not supported."
            sponsor
            exit 1
        elif [[ "$OSTYPE" == "freebsd"* ]]; then
          # ...
            echo "${CYAN}Cloud${NC}: Operating system not supported."
            sponsor
            exit 1
        else
           # Unknown.
            echo "${CYAN}Cloud${NC}: Operating system not supported."
            sponsor
            exit 1
        fi

        # Coming soon
        if [[ "$2" = "pow" ]] || [[ "$2" = "--pow" ]] || [[ "$2" = "--pow-server" ]]; then
            read -p 'Setup a Live Nano Node: Enter 'y' to continue: ' YES
            if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
                echo "Coming soon"
                # @reboot ~/nano-work-server/target/release/nano-work-server --gpu 0:0
                # $DIR/nano-work-server/target/release/nano-work-server --cpu 2
                # $DIR/nano-work-server/target/release/nano-work-server --gpu 0:0
                exit 1
            fi
            echo "Canceled"
            exit 1
        fi

    # Sorta working
    if [[ "$2" = "gpu" ]] || [[ "$2" = "--gpu" ]]; then
        read -p 'Setup NVIDIA GPU. Enter 'y' to continue: ' YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            sudo apt-get purge nvidia*
            sudo ubuntu-drivers autoinstall
            exit 1
        fi
        echo "Canceled"
        exit 1
    fi

    read -p 'Setup a Live Nano Node: Enter 'y' to continue: ' YES
    if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
        cd $DIR && git clone https://github.com/fwd/nano-docker.git
        LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
        cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
        exit 1
    fi
    echo "Canceled"
    exit 1

fi


