#!/bin/bash

#################################
## N2: Nano Command Line Tool  ##
## (c) 2018-3001 @nano2dev     ##
## Released under MIT License  ##
#################################

DIR=$(eval echo "~$different_user")

# Install '7z' if needed.
# if ! command -v 7z &> /dev/null; then
# 	if [  -n "$(uname -a | grep Ubuntu)" ]; then
# 		sudo apt install 7z -y
# 	else
# 		echo "${CYAN}Cloud${NC}: We could not auto install '7z'. Please install it manually, before continuing."
# 		exit 1
# 	fi
# fi

if ! command -v jq &> /dev/null; then
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install jq -y
	else
		echo "${CYAN}Cloud${NC}: We could not auto install 'jq'. Please install it manually, before continuing."
		exit 1
	fi
fi

# Install 'curl' if needed.
if ! command -v curl &> /dev/null; then
	# Really?! What kind of rinky-dink machine is this?
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install curl -y
	else
		echo "${CYAN}Cloud${NC}: We could not auto install 'curl'. Please install it manually, before continuing."
		exit 1
	fi
fi

VERSION=0.5-D
GREEN=$'\e[0;32m'
BLUE=$'\e[0;34m'
CYAN=$'\e[1;36m'
RED=$'\e[0;31m'
NC=$'\e[0m'
GREEN2=$'\e[1;92m'


LOCAL_DOCS=$(cat <<EOF
Usage
⏺  $ n2 setup node
⏺  $ n2 balance --local
⏺  $ n2 whois @moon
⏺  $ n2 account @kraken --json
⏺  $ n2 send @esteban 0.1
⏺  $ n2 qrcode @fosse
⏺  $ n2 plugin --list
EOF
)

CLOUD_DOCS=$(cat <<EOF
Nano.to Cloud
✅ $ n2 login
✅ $ n2 register
✅ $ n2 account
✅ $ n2 username
✅ $ n2 2factor
✅ $ n2 logout
EOF
)

OPTIONS_DOCS=$(cat <<EOF
Options
--cloud, -c  Use Cloud Node (Custodial).
--local, -l  Use Local Node (Non-Custodial).
--help, -h  Print CLI Documentation.
--docs, -d  Open Nano.to Documentation.
--update, -u  Get latest CLI Script.
--version, -v  Print current CLI Version.
--uninstall, -u  Remove CLI from system.
EOF
)

DOCS=$(cat <<EOF
${GREEN}USAGE:${NC}
$ n2 whois @moon --json
$ n2 node setup
$ n2 node balance
${GREEN}OPTIONS:${NC}
--help, -h  N2 Documentation.
--docs, -d  Nano.to Docs.
--update, -u  Update N2.
--version, -v  Print N2 Version.
--uninstall, -u  Remove N2.
EOF
)

if [[ $1 == "" ]] || [[ $1 == "help" ]] || [[ $1 == "list" ]] || [[ $1 == "--help" ]]; then
	cat <<EOF
$DOCS
EOF
	exit 1
fi

if [[ "$1" = "--json" ]]; then
	echo "Tip: Use the '--json' flag to get command responses in JSON."
	exit 1
fi

 
function sponsor() {
  echo "===========SPONSOR============"
  echo "  FREE 3-MONTH CLOUD SERVER   "
  echo "   (\$100 ON DIGITALOCEAN)    "
  echo "------------------------------"
  echo "https://m.do.co/c/f139acf4ddcb"
  echo "========ADVERTISE HERE========"
}

# ██████╗ ██████╗ ██╗ ██████╗███████╗
# ██╔══██╗██╔══██╗██║██╔════╝██╔════╝
# ██████╔╝██████╔╝██║██║     █████╗  
# ██╔═══╝ ██╔══██╗██║██║     ██╔══╝  
# ██║     ██║  ██║██║╚██████╗███████╗
# ╚═╝     ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝                                  

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then

    # For later
    # https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd
    # https://api.coingecko.com/api/v3/simple/price?ids=nano&vs_currencies=usd

    if [[ "$2" == "--json" ]]; then
        curl -s "https://nano.to/price?currency=USD" \
        -H "Accept: application/json" \
        -H "Content-Type:application/json" \
        --request GET | jq
        exit 1
    fi

    # AWARD FOR CLEANEST METHOD
    PRICE=$(curl -s "https://nano.to/price" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
        echo $PRICE
        exit 1
    fi

    echo "==============================="
    if [[ $(jq -r '.currency' <<< "$PRICE") == 'USD' ]]; then
        echo "      Ӿ 1.00 = \$ $(jq -r '.price' <<< "$PRICE")"
    else
        echo "      Ӿ 1.00 = $(jq -r '.price' <<< "$PRICE") $(jq -r '.currency' <<< "$PRICE")"
    fi 
    echo "==============================="
    echo "https://coinmarketcap.com/currencies/nano"
    echo "==============================="

    exit 1

fi

if [ "$1" = "whois" ]; then

    if [[ "$2" == *"nano_"* ]]; then
        ACCOUNT=$(curl -s https://nano.to/known.json | jq '. | map(select(.address == "'$2'"))' | jq '.[0]')
    else
        NAME=$(echo $2 | sed -e "s/\@//g")
        ACCOUNT=$(curl -s https://nano.to/known.json | jq '. | map(select(.name == "'$NAME'"))' | jq '.[0]')
    fi

    if [[ $ACCOUNT == "null" ]]; then
        echo "${RED}Error${NC}: Not found"
        exit
    fi

    if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
        echo $ACCOUNT
        exit 1
    fi

    # echo
    echo "==============================="
    echo "            ${CYAN}ACCOUNT${NC}       "
    echo "==============================="
    if [[ "$2" != *"nano_"* ]]; then
    echo "NAME: @"$(jq -r '.name' <<< "$ACCOUNT")
    echo "CREATED: "$(jq -r '.created' <<< "$ACCOUNT")
    fi
    echo "ADDRESS: "$(jq -r '.address' <<< "$ACCOUNT")
    echo "NANOLOOKER: https://nanolooker.com/account/"$(jq -r '.address' <<< "$ACCOUNT")

    exit 

fi

if [ "$2" = "download-ledger" ] || [ "$2" = "fast-sync" ] || [ "$2" = "--fs" ] || [ "$2" = "-fs" ] || [ "$2" = "-dl" ]; then

    ledgerDownloadLink=$(curl -s 'https://s3.us-east-2.amazonaws.com/repo.nano.org/snapshots/latest')

    wget -O ledger.7z ${ledgerDownloadLink} -q --show-progress

    printf "=> ${yellow}Unzipping and placing files to /Nano (takes a while)...${reset} "

    7z x ledger.7z -o ./Nano -y &> /dev/null

    # rm ledger.7z
    
    # printf "${green}Done.${reset}\n"
    
    exit
fi


#  ██████╗██╗  ██╗ █████╗ ██╗███╗   ██╗
# ██╔════╝██║  ██║██╔══██╗██║████╗  ██║
# ██║     ███████║███████║██║██╔██╗ ██║
# ██║     ██╔══██║██╔══██║██║██║╚██╗██║
# ╚██████╗██║  ██║██║  ██║██║██║ ╚████║
#  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
                                    
if [ "$2" = "nanolooker" ] || [ "$2" = "--nl" ] || [ "$2" = "-nl" ] || [ "$2" = "-l" ]; then

    if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
        echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
        exit 1
    fi

    ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
    -H "Accept: application/json" \
    -H "session: $(cat $DIR/.n2-session)" \
    -H "Content-Type:application/json" \
    --request GET)

    address=$(jq -r '.address' <<< "$ACCOUNT")

    open "https://nanolooker.com/account/$address"
    echo "==========================================="
    echo "                OPEN LINK                  "
    echo "==========================================="
    echo "https://nanolooker.com/account/$address"
    echo "==========================================="
    exit
fi


# ██████╗  ██████╗ ██╗    ██╗
# ██╔══██╗██╔═══██╗██║    ██║
# ██████╔╝██║   ██║██║ █╗ ██║
# ██╔═══╝ ██║   ██║██║███╗██║
# ██║     ╚██████╔╝╚███╔███╔╝
# ╚═╝      ╚═════╝  ╚══╝╚══╝ 
                           
if [[ $1 == "pow" ]] || [[ $1 == "--pow" ]]; then

    if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
        echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
        exit 1
    fi

    if [[ "$2" = "" ]]; then
    cat <<EOF
Usage:
  $ n2 pow @esteban
  $ n2 pow nano_1address.. --json
EOF
        exit 1
    fi

    ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
    -H "Accept: application/json" \
    -H "session: $(cat $DIR/.n2-session)" \
    -H "Content-Type:application/json" \
    --request GET)

    if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
    rm $DIR/.n2-session
    echo "==============================="
    echo "    LOGGED OUT FOR SECURITY    "
    echo "==============================="
    echo "Use 'n2 login' to log back in. "
    echo "==============================="
    echo
    exit 1
    fi

    POW=$(curl -s "https://nano.to/$2/pow" \
    -H "Accept: application/json" \
    -H "Authorization: $(jq -r '.pow_key' <<< "$ACCOUNT")" \
    -H "Content-Type:application/json" \
    --request GET)

    if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
        echo $POW
        exit 1
    fi

    if [[ $(jq -r '.error' <<< "$POW") == "429" ]]; then
        echo "==============================="
        echo "         PLEASE WAIT           "
        echo "==============================="
        echo "  Use 'n2 add pow' or wait.    "
        echo "==============================="
        echo "Docs: https://docs.nano.to/pow "
        echo "==============================="
        exit 1
    fi

    # echo $(jq -r '.work' <<< "$POW")

    echo "==============================="
    echo "       ☁️   CLOW POW   ☁️      "
    echo "==============================="
    echo "WORK: $(jq -r '.work' <<< "$POW")"
    echo "DIFF: $(jq -r '.difficulty' <<< "$POW")"
    echo "CREDITS: $(jq -r '.credits' <<< "$POW")"
    # echo ": $(jq -r '.error' <<< "$work")"
    echo "==============================="

    exit 1

fi

#  ██████╗ ██████╗ ███╗   ██╗██╗   ██╗███████╗██████╗ ████████╗
# ██╔════╝██╔═══██╗████╗  ██║██║   ██║██╔════╝██╔══██╗╚══██╔══╝
# ██║     ██║   ██║██╔██╗ ██║██║   ██║█████╗  ██████╔╝   ██║   
# ██║     ██║   ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██╔══██╗   ██║   
# ╚██████╗╚██████╔╝██║ ╚████║ ╚████╔╝ ███████╗██║  ██║   ██║   
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝   
                                                             

if [ "$2" = "convert" ] || [ "$2" = "--convert" ] || [ "$2" = "-c" ] || [ "$2" = "c" ] || [ "$2" = "-c" ]; then
    TIMELINE='week'
    echo "================================="
    echo "       UNDER CONSTRUCTION        "
    echo "================================="
    echo "'n2 convert' is under development. Update N2 in a $TIMELINE or so. Tweet @nano2dev to remind me to get it done."
    echo "================================="
    echo "https://twitter.com/nano2dev"
    echo "================================="
    exit 1
fi

function local_send() {

    # if curl -s --fail -X POST '[::1]:7076'; then
    #     echo ""
    # else
    #    echo "${CYAN}Node${NC}: No local Node found. Use 'n2 setup node'."
    #    exit 1
    # fi;


    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Username or Nano Address."
        exit 1
    fi
    
    if [[ $3 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing amount. Use 'all' to send entire balance."
        exit 1
    fi

    if [[ $4 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing source address."
        exit 1
    fi

    AMOUNT=$2
    DEST=$3
    SRC=$4

    # echo $1
    # echo $2
    # echo $3
    # echo $4

    # exit 1

    if [[ $(cat $DIR/.n2-wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID >> $DIR/.n2-wallet
    else
        WALLET_ID=$(cat $DIR/.n2-wallet)
    fi
    # WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )

    # SRC="$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'nano_' | awk '{ print $NF}' | tr -d '\r')"

    UUID=$(cat /proc/sys/kernel/random/uuid)

    # TODO: Replace with nano_to_raw... but no Decimal support
    AMOUNT_IN_RAW=$(curl -s "https://api.nano.to/convert/toRaw/$3" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    if [[ "$2" == *"nano_"* ]]; then
        DEST=$2
    else
        NAME=$(echo $2 | sed -e "s/\@//g")
        ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-names/master/known.json | jq '. | map(select(.name == "'$NAME'"))' | jq '.[0]')
        DEST=$(jq -r '.address' <<< "$ACCOUNT")
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

    # echo "asd"
    # echo $ACCOUNT

    # exit 1

    POW=$(curl -s "https://pow.nano.to/$(jq -r '.frontier' <<< "$ACCOUNT")" \
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

    # echo $SEND_ATTEMPT

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

# if [[ "$1" = "node" ]] && [[ "$2" = "--wallet" ]]; then
#     # docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}'
# fi

if [[ "$1" = "--seed" ]] || [[ "$1" = "--secret" ]]; then
  WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}')
  SEED=$(docker exec -it nano-node /usr/bin/nano_node --wallet_decrypt_unsafe --wallet=$WALLET_ID | grep 'Seed' | awk '{ print $NF}' | tr -d '\r')
  echo $SEED
fi


if [[ $1 == "send" ]] || [[ $1 == "--send" ]] || [[ $1 == "-s" ]]; then
    cat <<EOF
$(local_send $1 $2 $3 $4)
EOF
    exit 1
fi


if [[ $1 == "address" ]]; then

    # if curl -f -d '{ "action": "block_count" }' '[::1]:7076'; then
    #     echo ""
    # else
    #    echo "${CYAN}Node${NC}: No local Node found. Use 'n2 setup node'"
    #    exit 1
    # fi;

    SRC=$(nano-node /usr/bin/nano_node --wallet_list | grep 'nano_' | awk '{ print $NF}' | tr -d '\r')

    echo "asd"

    exit 

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

    exit 1

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

if [[ $1 == "balance" ]] || [[ $1 == "accounts" ]] || [[ $1 == "account" ]] || [[ $1 == "ls" ]]; then

    # if curl -s --fail -X POST '[::1]:7076'; then
    #     echo ""
    # else
    #    echo "${CYAN}Node${NC}: No local Node found. Use 'n2 setup node'"
    #    exit 1
    # fi;

    # if [[ $2 == "" ]]; then
    #     echo "${CYAN}Node${NC}: Missing Username or Nano Address."
    #     exit 1
    # fi

    echo "Balance. lol"

    exit 

fi


if [[ "$2" = "setup" ]] || [[ "$2" = "--setup" ]] || [[ "$2" = "install" ]]; then

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo ""
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "${CYAN}Node${NC}: You're on a Mac. OS not supported. Try a Cloud server running Ubuntu."
        sponsor
        exit 1
      # Mac OSX
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 1
      # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 1
      # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
      # I'm not sure this can happen.
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 1
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
      # ...
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 1
    else
       # Unknown.
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 1
    fi

    # Coming soon
    if [[ "$2" = "pow" ]] || [[ "$2" = "--pow" ]] || [[ "$2" = "pow-proxy" ]] || [[ "$2" = "pow-server" ]]; then
        read -p 'Setup Nano PoW Server: Enter 'y': ' YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
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

    read -p 'Attempt to setup a Nano Node: Enter 'y': ' YES
    if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
        # https://github.com/fwd/nano-docker
        curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
        # cd $DIR && git clone https://github.com/fwd/nano-docker.git
        # LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
        # cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
        exit 1
    fi
    echo "Canceled"
    exit 1

fi


# ██╗  ██╗███████╗██╗     ██████╗ 
# ██║  ██║██╔════╝██║     ██╔══██╗
# ███████║█████╗  ██║     ██████╔╝
# ██╔══██║██╔══╝  ██║     ██╔═══╝ 
# ██║  ██║███████╗███████╗██║     
# ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     

if [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-help" ] || [ "$1" = "-h" ]; then
    echo "$DOCS"
    exit 1
fi

if [ "$1" = "list" ] || [ "$1" = "ls" ] || [ "$1" = "--ls" ] || [ "$1" = "-ls" ] || [ "$1" = "-l" ]; then
cat <<EOF
$DOCS
EOF
    exit 1
fi

# ██╗   ██╗███████╗██████╗ ███████╗██╗ ██████╗ ███╗   ██╗
# ██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔═══██╗████╗  ██║
# ██║   ██║█████╗  ██████╔╝███████╗██║██║   ██║██╔██╗ ██║
# ╚██╗ ██╔╝██╔══╝  ██╔══██╗╚════██║██║██║   ██║██║╚██╗██║
#  ╚████╔╝ ███████╗██║  ██║███████║██║╚██████╔╝██║ ╚████║
#   ╚═══╝  ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝                                      

if [[ "$1" = "v" ]] || [[ "$1" = "-v" ]] || [[ "$1" = "--version" ]] || [[ "$1" = "version" ]]; then
    echo "Version: $VERSION"
    exit 1
fi


# ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
# ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
# ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗  
# ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝  
# ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
#  ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝
                                                  
if [ "$1" = "u" ] || [ "$2" = "-u" ] || [ "$1" = "install" ] || [ "$1" = "--install" ]  || [ "$1" = "--update" ] || [ "$1" = "update" ]; then
    if [ "$2" = "--dev" ] || [ "$2" = "dev" ]; then
        sudo rm /usr/local/bin/n2
        curl -s -L "https://github.com/fwd/n2/raw/dev/n2.sh" -o /usr/local/bin/n2
        sudo chmod +x /usr/local/bin/n2
        echo "Installed latest 'development' version."
        exit 1
    fi
    if [ "$2" = "--prod" ] || [ "$2" = "prod" ]; then
        sudo rm /usr/local/bin/n2
        curl -s -L "https://github.com/fwd/n2/raw/master/n2.sh" -o /usr/local/bin/n2
        sudo chmod +x /usr/local/bin/n2
        echo "Installed latest 'stable' version."
        exit 1
    fi
    curl -s -L "https://github.com/fwd/n2/raw/master/n2.sh" -o /usr/local/bin/n2
    sudo chmod +x /usr/local/bin/n2
    echo "Installed latest version."
    exit 1
fi


# ██╗   ██╗███╗   ██╗██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
# ██║   ██║████╗  ██║██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
# ██║   ██║██╔██╗ ██║██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
# ██║   ██║██║╚██╗██║██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
# ╚██████╔╝██║ ╚████║██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
#  ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝

if [[ "$1" = "--uninstall" ]] || [[ "$1" = "-u" ]]; then
    sudo rm /usr/local/bin/n2
    rm $DIR/.n2-favorites
    rm $DIR/.n2-session
    rm $DIR/.n2-rpc
    echo "CLI removed. Thanks for using N2. Hope to see you soon."
    exit 1
fi


# ██╗  ██╗██╗   ██╗██╗  ██╗
# ██║  ██║██║   ██║██║  ██║
# ███████║██║   ██║███████║
# ██╔══██║██║   ██║██╔══██║
# ██║  ██║╚██████╔╝██║  ██║
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                         
cat <<EOF
Commant not found. Use 'n2 help' to see all commands.
EOF