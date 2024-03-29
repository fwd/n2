#!/bin/bash

#################################
## N2: Nano Command Line Tool  ##
## (c) 2018-3001 @nano2dev     ##
## Released under MIT License  ##
#################################

VERSION=0.2.3
GREEN=$'\e[0;32m'
BLUE=$'\e[0;34m'
CYAN=$'\e[1;36m'
RED=$'\e[0;31m'
NC=$'\e[0m'
GREEN2=$'\e[1;92m'
DIR=$(eval echo "~$different_user")

# Project Folder
mkdir -p $DIR/.n2

# Install '7z' if needed.
# if ! command -v 7z &> /dev/null; then
# 	if [  -n "$(uname -a | grep Ubuntu)" ]; then
# 		sudo apt install 7z -y
# 	else
# 		echo "${CYAN}Cloud${NC}: We could not auto install '7z'. Please install it manually, before continuing."
# 		exit 0
# 	fi
# fi

if ! command -v jq &> /dev/null; then
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install jq -y
	else
		echo "${CYAN}Cloud${NC}: We could not auto install 'jq'. Please install it manually, before continuing."
		exit 0
	fi
fi

# Install 'curl' if needed.
if ! command -v curl &> /dev/null; then
	# Really?! What kind of rinky-dink machine is this?
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install curl -y
	else
		echo "${CYAN}Cloud${NC}: We could not auto install 'curl'. Please install it manually, before continuing."
		exit 0
	fi
fi



function nano_to_raw() {
  if [ "$1" == "0" ]; then
    echo "0"
    exit 0
  fi
  amount=$1; before=$(echo $amount | sed 's/\..*//'); [[ $amount == *.* ]] && after=$(echo ${amount}000000000000000000000000000000 | cut -d "." -f2) || after=000000000000000000000000000000; after=${after:0:30}; full=$before$after; trimmed=$(echo $full | sed 's/^0*//'); echo $trimmed
}

function raw_to_nano() {
  if [ "$1" == "0" ]; then
    echo "0"
    exit 0
  fi
  raw=$1; raw="000000000000000000000000000000$raw"; before=$(echo $raw | sed 's/..............................$//'); after=${raw: -30}; trimmed=$(echo $before.$after | sed 's/^0*//' | sed 's/0*$//' | sed 's/\.$//'); if [[ ${trimmed:0:1} == '.' ]]; then echo "0$trimmed"; else echo $trimmed; fi
}

if [ "$1" = "nano_to_raw" ]; then
    nano_to_raw $2
    exit 0
fi

if [ "$1" = "raw_to_nano" ]; then
    raw_to_nano $2
    exit 0
fi



## Compare two decimals
# FAUCET_BALANCE=$(n2 balance nano_1faucet7b6xjyha7m13objpn5ubkquzd6ska8kwopzf1ecbfmn35d1zey3ys --nano)
# if [ 1 -eq "$(echo "${FAUCET_BALANCE} >= 5" | bc)" ]; then
#         echo $FAUCET_BALANCE
# else
#         echo "Not enough."
# fi


function findAddress() {
  echo $1 | jq '.[] | select(contains("'$2'")) | .' | head -1
}


function get_accounts() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
      WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
      echo $WALLET_ID > $DIR/.n2/wallet
  else
      WALLET_ID=$(cat $DIR/.n2/wallet)
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

    # COUNT="{ \"accounts\": \""$(jq -r '.accounts | length' <<< "$accounts")"\"  }"
    # COUNT="{ \"accounts\": \""$(jq -r '.accounts | length' <<< "$accounts")"\"  }"

    # echo $(jq -n "$COUNT") 
    echo $accounts
    # echo $(jq '.accounts[0]' <<< "") 
    # echo $(jq '.accounts[0]' <<< "$accounts") 

}

function get_balance() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  if [ -z "$1" ]; then
        
      # all_accounts=$(get_accounts) 
      ALL_ACCOUNTS=$(get_accounts) 
      THE_ADDRESS=$(jq '.accounts[0]' <<< "$ALL_ACCOUNTS" | tr -d '"') 
      # _ADDRESS=$(jq '.accounts[0]' <<< "$all_accounts" | tr -d '"') 

  else
      
      if [[ "$1" == *"nano_"* ]]; then
          THE_ADDRESS=$1
      else
          THE_NAME=$(echo $1 | sed -e "s/\@//g")
          THE_ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$THE_NAME'"))' | jq '.[0]')
          THE_ADDRESS=$(jq -r '.address' <<< "$THE_ACCOUNT")
      fi

  fi

  if curl -sL --fail '[::1]:7076' -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

ACCOUNT=$(curl -s $NODE_URL \
  -H "Accept: application/json" \
  -H "Content-Type:application/json" \
  --request POST \
  --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$THE_ADDRESS",
    "representative": "true",
    "pending": "true",
    "receivable": "true"
}
EOF
))

  echo $ACCOUNT


}

function list_accounts() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
    NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
      echo -n ""
  else
      echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
      exit 0
  fi
  
  accounts_on_file=$(get_accounts)

  if [[ "$1" == "--json" ]]; then
      echo $(jq '.accounts' <<< "$accounts_on_file")
      exit 0
  fi

  readarray -t my_array < <(jq '.accounts' <<< "$accounts_on_file")
  
  index=1

  for item in "${my_array[@]}"; do
    if [[ "$item" == *"nano_"* ]]; then
      
      if [[ "$1" == "--show" ]] || [[ "$2" == "--show" ]]; then
        
        echo "[$index]:" $item | tr -d '"'

      elif [[ "$1" == "--balance" ]] || [[ "$1" == "-b" ]]; then

        CLEAN_ADDRESS=$(echo $item | tr -d '"' | tr -d ',')

        # CLEAN_ADDRESS2=$()
        
        ITEM_ACCOUNT=$(curl -s $NODE_URL \
  -H "Accept: application/json" \
  -H "Content-Type:application/json" \
  --request POST \
  --data @<(cat <<EOF
{
    "action": "account_info",
    "account": "$CLEAN_ADDRESS",
    "representative": "true",
    "pending": "true",
    "receivable": "true"
}
EOF
))
      ADDRESSS_BALANCE=$(jq '.balance' <<< "$ITEM_ACCOUNT" | tr -d '"')

      echo "[$index]:" $(echo $CLEAN_ADDRESS | cut -c1-20 ) "[$(raw_to_nano $ADDRESSS_BALANCE | cut -c1-6)]"

      else
        echo "[$index]:" $item | tr -d '"' | cut -c1-20
      fi

      let "index++"
    fi
  done

}

function print_address() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  accounts_on_file=$(get_accounts)

  if [[ -z "$1" ]]; then
    ACCOUNT_INDEX="0"
  else
    ACCOUNT_INDEX=$(expr $1 - 1)
  fi

  # total_accounts=$(jq '.accounts | length' <<< "$accounts_on_file")  

  # if [[ "$2" == "--hide" ]] || [[ "$2" == "-hide" ]]; then
    # first_account=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 
  # else
  the_account=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 
  # fi

  echo $the_account

}


function print_balance() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  accounts_on_file=$(get_accounts)

  total_accounts=$(jq '.accounts | length' <<< "$accounts_on_file") 

  if [[ -z "$1" ]] || [[ "$1" == "--hide" ]] || [[ "$1" == "-hide" ]]; then
    first_account=$(jq '.accounts[0]' <<< "$accounts_on_file" | tr -d '"') 
  else
    first_account=$1
  fi

  if [ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null; then
           
      if [[ -z "$1" ]]; then
        ACCOUNT_INDEX="0"
      else
        ACCOUNT_INDEX=$(expr $1 - 1)
      fi

      first_account=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 

  else
      
    first_account=$1

  fi

  account_info=$(get_balance "$first_account")

  if [[ "$2" == "--raw" ]]; then
      echo $(jq -r '.balance' <<< "$account_info")
      exit 0
  fi

  if [[ "$2" == "--nano" ]] || [[ "$2" == "--text" ]]; then
      raw_to_nano $(jq -r '.balance' <<< "$account_info")
      exit 0
  fi

  if [[ "$2" == "--json" ]]; then
      echo $account_info
      exit 0
  fi

  if [[ "$(jq -r '.balance' <<< "$account_info")" == "null" ]]; then
    # echo
    echo "================================"
    echo "             ${RED}ERROR${NC}              "
    echo "================================"
    echo "$(jq -r '.error' <<< "$account_info") "
    echo "================================"
    echo
    exit 0
  fi

  account_balance=$(jq '.balance' <<< "$account_info" | tr -d '"') 

  account_pending=$(jq '.pending' <<< "$account_info" | tr -d '"') 

  if [[ $account_balance == "0" ]]; then
    balance_in_decimal_value=$account_balance
  else
    balance_in_decimal_value=$(raw_to_nano $account_balance)
  fi

  if [[ $account_pending == "0" ]]; then
    echo -n ""
    pending_in_decimal_value="0"
  else 
    pending_in_decimal_value=$(raw_to_nano $account_pending)
  fi

  mkdir -p $DIR/.n2/data
  metadata=$(find $DIR/.n2/data -maxdepth 1 -type f | wc -l | xargs)

  if [[ $(cat $DIR/.n2/title 2>/dev/null) == "" ]]; then
      CLI_TITLE="        NANO CLI (N2)"
  else
      CLI_TITLE=$(cat $DIR/.n2/title)
  fi

  if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
      echo "{ \"address\": \""first_account"\", \"balance\": \""balance_in_decimal_value"\", \"pending\": \""pending_in_decimal_value"\", \"accounts\": \""total_accounts"\", \"metadata\": \""metadata"\"   }"
      exit 0
  fi

  NODE_VERSION=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "version"
}
EOF
  ))

  NODE_SYNC=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "block_count"
}
EOF
  ))

  NODE_BLOCK_COUNT=$(jq '.count' <<< "$NODE_SYNC" | tr -d '"') 
  NODE_BLOCK_UNCHECKED=$(jq '.unchecked' <<< "$NODE_SYNC" | tr -d '"') 
  NODE_BLOCK_CEMENTED=$(jq '.cemented' <<< "$NODE_SYNC" | tr -d '"') 

  INT_NODE_BLOCK_COUNT=$(expr $NODE_BLOCK_COUNT + 0)
  INT_NODE_BLOCK_UNCHECKED=$(expr $NODE_BLOCK_UNCHECKED + 0)
  INT_NODE_BLOCK_CEMENTED=$(expr $NODE_BLOCK_CEMENTED + 0)

  SYNC_PERCENT=$(awk "BEGIN {print  (($INT_NODE_BLOCK_COUNT - $INT_NODE_BLOCK_UNCHECKED) / $INT_NODE_BLOCK_COUNT) * 100 }")

  if [[ $SYNC_PERCENT == *"99.9999"* ]]; then
    FINAL_SYNC_PERCENT="100"
  else
    FINAL_SYNC_PERCENT=$SYNC_PERCENT
  fi

  echo "============================="
  echo "           ${GREEN}BALANCE${NC}"
  echo "============================="
  if [[ "$1" == "--hide" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "hide" ]]; then
    echo "${PURP}Address:${NC} $(echo "$first_account" | cut -c1-17)***"
  else
    echo "${PURP}Address:${NC} $(echo "$first_account" | cut -c1-17)***"
    echo "${PURP}Balance:${NC} $balance_in_decimal_value"
    echo "${PURP}Pending:${NC} $pending_in_decimal_value"
  fi
  echo "============================="
  echo "${PURP}Node:${NC} ${GREEN}$(jq '.node_vendor' <<< "$NODE_VERSION" | tr -d '"') @ $FINAL_SYNC_PERCENT%${NC}"
  echo "============================="
DOCS=$(cat <<EOF
${GREEN}$ n2 [ balance | send | address ]${NC}
EOF
)
cat <<EOF
$DOCS
EOF
  # else
  #   echo -n ""
  # fi

}



function print_history() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  accounts_on_file=$(get_accounts)

  if [[ -z "$1" ]] || [[ "$1" == "--hide" ]] || [[ "$1" == "-hide" ]]; then
    first_account=$(jq '.accounts[0]' <<< "$accounts_on_file" | tr -d '"') 
  else
    first_account=$1
  fi

  if [[ -z "$2" ]]; then
    count='100'
  else
    count=$2
  fi

  ADDRESS_HISTORY=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
  "action": "account_history", 
  "account": "$first_account",
  "count": "$count"
}
EOF
  ))

  echo $ADDRESS_HISTORY

}


function print_pending() {

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL > $DIR/.n2/node
  else
      NODE_URL=$(cat $DIR/.n2/node)
  fi

  if curl -sL --fail $NODE_URL -o /dev/null; then
    echo -n ""
  else
    echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  accounts_on_file=$(get_accounts)

  if [[ -z "$1" ]] || [[ "$1" == "--hide" ]] || [[ "$1" == "-hide" ]]; then
    first_account=$(jq '.accounts[0]' <<< "$accounts_on_file" | tr -d '"') 
  else
    first_account=$1
  fi

  if [[ -z "$2" ]]; then
    count='100'
  else
    count=$2
  fi

  ADDRESS_HISTORY=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
  "action": "pending", 
  "account": "$first_account",
  "count": "$count",
  "source": "true"
}
EOF
  ))

  echo $ADDRESS_HISTORY

}



LOCAL_DOCS=$(cat <<EOF
${GREEN}USAGE:${NC}
$ n2 setup
$ n2 balance
$ n2 whois @moon
$ n2 send @esteban 0.1
$ n2 install (Coming Soon)
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
$ n2 setup
$ n2 balance
$ n2 send @esteban 0.1 ADDRESS
$ n2 whois @moon
EOF
)


if [[ $1 == "" ]]; then
 
  print_balance 1
 
	exit 0

fi

if [[ "$1" = "--json" ]]; then
	echo "Tip: Use the '--json' flag to get command responses in JSON."
	exit 0
fi



# ██████╗ ██████╗ ██╗ ██████╗███████╗
# ██╔══██╗██╔══██╗██║██╔════╝██╔════╝
# ██████╔╝██████╔╝██║██║     █████╗  
# ██╔═══╝ ██╔══██╗██║██║     ██╔══╝  
# ██║     ██║  ██║██║╚██████╗███████╗
# ╚═╝     ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝                                  

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then

    if [[ -z "$2" ]]; then
        FIAT='usd'
    else  
        FIAT=$2
    fi

    if [[ $(cat $DIR/.n2/price-url 2>/dev/null) == "" ]]; then
        PRICE_URL="https://api.coingecko.com/api/v3/simple/price?ids=nano&vs_currencies="
        echo $PRICE_URL > $DIR/.n2/price-url
    else
        PRICE_URL=$(cat $DIR/.n2/price-url)
    fi

    PRICE=$(curl -s "$PRICE_URL"$FIAT \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    echo $(jq -r '.nano' <<< "$PRICE")

    exit 0

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
        exit 0
    fi

    # echo
    echo "==============================="
    echo "            ${CYAN}ACCOUNT${NC}       "
    echo "==============================="
    if [[ "$2" != *"nano_"* ]]; then
    echo "NAME: @"$(jq -r '.name' <<< "$ACCOUNT")
    # echo "CREATED: "$(jq -r '.created' <<< "$ACCOUNT")
    fi
    echo "ADDRESS: "$(jq -r '.address' <<< "$ACCOUNT")
    echo "==============================="
    echo "https://nanolooker.com/account/"$(jq -r '.address' <<< "$ACCOUNT")

    exit 

fi



function local_send() {

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
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
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    UUID=$(uuidgen)
    accounts_on_file=$(get_accounts)

    if [[ -z "$4" ]] || [[ "$4" == "--json" ]]; then

        if [[ $(cat $DIR/.n2/main 2>/dev/null) == "" ]]; then
            SRC=$(jq '.accounts[0]' <<< "$accounts_on_file" | tr -d '"') 
            echo $SRC > $DIR/.n2/main
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
    "account": "$SRC",
    "representative": "true",
    "pending": "true",
    "receivable": "true"
}
EOF
  ))

        AMOUNT_FINAL=$(jq -r '.balance' <<< "$ACCOUNT")

        if [[ $AMOUNT_FINAL == "0" ]]; then
            echo "${RED}Error:${NC} Balance is 0."
            exit 0
        fi
        
    else
        AMOUNT_FINAL=$(nano_to_raw $3)
    fi

    if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
           
      if [[ -z "$2" ]]; then
        ACCOUNT_INDEX="0"
      else
        ACCOUNT_INDEX=$(expr $2 - 1)
      fi

      DEST=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 

    else

        if [[ "$2" == *"nano_"* ]]; then
            DEST=$2
        else
            NAME_DEST=$(echo $2 | sed -e "s/\@//g")
            SRC_ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$NAME_DEST'"))' | jq '.[0]')
            DEST=$(jq -r '.address' <<< "$SRC_ACCOUNT")
            if [[ "$DEST" == "null" ]]; then
                echo "${RED}Error:${NC} Invalid or Expired Username."
                exit 0
            fi
        fi
        
    fi


    ACCOUNT=$(curl -s $NODE_URL \
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

    CURRENT_BALANCE=$(jq -r '.balance' <<< "$ACCOUNT")

    if [[ "$5" == "--json" ]]; then
        echo -n ""
    else    
        SEND_CONFIRM=$(cat <<EOF
==================================
          ${GREEN}CONFIRM SEND${NC}
==================================
${GREEN}AMOUNT:${NC} $(raw_to_nano $AMOUNT_FINAL)
${GREEN}TO:${NC} $DEST
${GREEN}FROM:${NC} $SRC
${GREEN}BALANCE:${NC} $(raw_to_nano $CURRENT_BALANCE)
==================================
Press 'Y' to continue:
EOF
)
        read -p "$SEND_CONFIRM " SEND_CONFIRM_YES
        if [[ $SEND_CONFIRM_YES != 'y' ]] && [[ $SEND_CONFIRM_YES != 'Y' ]]; then
          echo "Canceled."
          exit 0
        fi
    fi

    SEND_ATTEMPT=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "send",
    "wallet": "$WALLET_ID",
    "source": "$SRC",
    "destination": "$DEST",
    "amount": "$AMOUNT_FINAL",
    "id": "$UUID"
}
EOF
    ))

    if [[ "$5" == "--json" ]]; then
        echo $SEND_ATTEMPT
        exit 0
    fi

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

    echo "==============================="
    echo "         ${GREEN}NANO RECEIPT${NC}          "
    echo "==============================="
    echo "${GREEN}AMOUNT${NC}: "$(raw_to_nano $AMOUNT_FINAL)
    echo "${GREEN}TO${NC}: "$DEST
    echo "${GREEN}FROM${NC}: "$SRC
    # echo "${GREEN}HASH${NC}: "$(jq -r '.block' <<< "$SEND_ATTEMPT")
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
$(local_send $1 $2 $3 $4 $5)
EOF
    exit 0
fi

if [[ $1 == "add" ]] || [[ $1 == "create" ]] || [[ $1 == "account_create" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]]; then
        echo -n ""
    else    
        read -p "${GREEN}Cloud${NC}: Add a new address? Enter 'y' to continue: " SANITY_CHECK
        if [[ $SANITY_CHECK != 'y' ]] && [[ $SANITY_CHECK != 'Y' ]]; then
          echo "Canceled."
          exit 0
        fi
    fi

  NEW_ACCOUNT=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_create",
    "wallet": "$WALLET_ID"
}
EOF
  ))

    if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]]; then
        echo $NEW_ACCOUNT
        exit 0
    fi

    echo "============================="
    echo "      ${GREEN}ACCOUNT CREATED${NC}"
    echo "============================="
    echo $(jq '.account' <<< "$NEW_ACCOUNT" | tr -d '"')

    exit 0

fi


if [[ "$1" = "add_vanity" ]] || [[ "$1" = "vanity_add" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ ! -f "$DIR/.cargo/bin/nano-vanity" ]]; then
        echo "Nano-Vanity not installed. Use 'n2 vanity' to setup."
        exit 0
    else 
        VANITY_PATH="$DIR/.cargo/bin/nano-vanity"
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    GPU_INSTALLED=$(lspci -vnnn | perl -lne 'print if /^\d+\:.+(\[\S+\:\S+\])/' | grep VGA)

    if [[ $GPU_INSTALLED == *"paravirtual"* ]]; then
        THREAD_COUNT=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
        USE_THREAD_COUNT=$(awk "BEGIN {print ($THREAD_COUNT - 1) }")
        VANITY_ADDRESS=$($VANITY_PATH $2 --no-progress --threads $USE_THREAD_COUNT --simple-output)
    else 
        VANITY_ADDRESS=$($VANITY_PATH $2 --no-progress --gpu-device 0 --gpu-platform 0 --simple-output)
    fi

    VANITY_ADDRESS_ARRAY=($VANITY_ADDRESS)
    
    if [[ ${VANITY_ADDRESS_ARRAY[1]} == *"nano_"* ]]; then
        
        NEW_ACCOUNT=$(curl -s $NODE_URL \
        -H "Accept: application/json" \
        -H "Content-Type:application/json" \
        --request POST \
        --data @<(cat <<EOF
{
  "action": "wallet_add",
  "wallet": "$WALLET_ID",
  "key": "${VANITY_ADDRESS_ARRAY[0]}"
}
EOF
  ))

    echo $NEW_ACCOUNT

    fi

    exit 0

fi


if [[ "$1" = "adhoc_account" ]] || [[ "$1" = "adhoc_add" ]]; then

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Private Seed."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    # VANITY_ADDRESS=$(nano-vanity $2 --no-progress --gpu-device 0 --gpu-platform 0 --simple-output)
    # VANITY_ADDRESS_ARRAY=($VANITY_ADDRESS)
    
    NEW_ACCOUNT=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
  "action": "wallet_add",
  "wallet": "$WALLET_ID",
  "key": "$2"
}
EOF
  ))

    echo $NEW_ACCOUNT

    exit 0

fi


if [[ $1 == "remove" ]] || [[ $1 == "rm" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Address to remove."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    accounts_on_file=$(get_accounts)

    if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
        if [[ -z "$2" ]]; then
          ACCOUNT_INDEX="0"
        else
          ACCOUNT_INDEX=$(expr $2 - 1)
        fi
        SRC=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 
    else  
        SRC=$2
    fi

    if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]]; then
        echo -n ""
    else    
        read -p "${GREEN}Cloud${NC}: Remove '$SRC' from wallet? Enter 'y' to continue: " SANITY_CHECK
        if [[ $SANITY_CHECK != 'y' ]] && [[ $SANITY_CHECK != 'Y' ]]; then
          echo "Canceled."
          exit 0
        fi
    fi

    REMOVE=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "account_remove",
    "wallet": "$WALLET_ID",
    "account": "$SRC"
}
EOF
    ))

    echo $REMOVE

    exit 0

fi


if [[ $1 == "wallet" ]]; then


    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    WALLET=$(curl -s $NODE_URL \
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

if [[ $1 == "history" ]]; then

    print_history $2 $3 $4

    exit 0

fi

if [[ $1 == "pending" ]]; then

    print_pending $2 $3 $4

    exit 0

fi

if [[ $1 == "b" ]] || [[ $1 == "balance" ]] || [[ $1 == "account" ]]; then

    accounts_on_file=$(get_accounts)

    if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
        if [[ -z "$2" ]]; then
          ACCOUNT_INDEX="0"
        else
          ACCOUNT_INDEX=$(expr $2 - 1)
        fi
        SRC=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 
    else
        SRC=$2
    fi

    print_balance $SRC $3 $4

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
        echo $3 > "$DIR/.n2/$2"
    else
        echo "Failed to parse JSON"
    fi
    exit 0
fi


if [[ $1 == "list" ]] || [[ $1 == "ls" ]] || [[ $1 == "l" ]]; then

    list_accounts $2 $3

    exit 0

fi



function disburse() {

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Params. Usage 'n2 $1 [to] [amount] [from]'"
        exit 0
    fi
    
    if [[ $3 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Params. Use 'all' to disburse entire balance."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    UUID=$(uuidgen)
    accounts_on_file=$(get_accounts)

    if [[ -z "$4" ]]; then

        if [[ $(cat $DIR/.n2/main 2>/dev/null) == "" ]]; then
            SRC=$(jq '.accounts[0]' <<< "$accounts_on_file" | tr -d '"') 
            echo $SRC > $DIR/.n2/main
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
    "account": "$SRC",
    "representative": "true",
    "pending": "true",
    "receivable": "true"
}
EOF
  ))

        AMOUNT_FINAL=$(jq -r '.balance' <<< "$ACCOUNT")

        if [[ $AMOUNT_FINAL == "0" ]]; then
            echo "${RED}Error:${NC} Balance is 0."
            exit 0
        fi
        
    else
        AMOUNT_FINAL=$(nano_to_raw $3)
    fi

    if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
           
      if [[ -z "$2" ]]; then
        ACCOUNT_INDEX="0"
      else
        ACCOUNT_INDEX=$(expr $2 - 1)
      fi

      DEST=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 

    else

        if [[ "$2" == *"nano_"* ]]; then
            DEST=$2
        else
            NAME_DEST=$(echo $2 | sed -e "s/\@//g")
            SRC_ACCOUNT=$(curl -s https://raw.githubusercontent.com/fwd/nano-to/master/known.json | jq '. | map(select(.name == "'$NAME_DEST'"))' | jq '.[0]')
            DEST=$(jq -r '.address' <<< "$SRC_ACCOUNT")
        fi
        
    fi

    if [ -f "$2" ]; then
        ADDRESS_LIST=$(cat $2)
    else
        ADDRESS_LIST=$(curl -s "https://api.nano.to/list/$2")
    fi

    if [[ "$ADDRESS_LIST" == *"Cannot GET"* ]]; then
      echo "${RED}Error:${NC} Invalid List. Public Lists: Names, Reps"
      exit 0
    fi

    if [ $(jq '.[]' <<< "$ADDRESS_LIST" > /dev/null 2>&1; echo $?) -eq 0 ]; then
      echo -n ""
    else
      echo "${RED}Error:${NC} Invalid JSON array. Fix and try again. $3"
      exit 0
    fi

    SRC_ACCOUNT_DATA=$(curl -s '[::1]:7076' \
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

    CURRENT_BALANCE=$(jq -r '.balance' <<< "$SRC_ACCOUNT_DATA")
    CURRENT_BALANCE_NANO=$(raw_to_nano $CURRENT_BALANCE)

    if (( $(awk "BEGIN { print $CURRENT_BALANCE_NANO < $3 }") == "1" )); then
        echo "${RED}Error:${NC} Insufficient Balance: $CURRENT_BALANCE_NANO"
        exit 0
    fi

    readarray -t my_array < <(jq '.[]' <<< "$ADDRESS_LIST")

    COUNT=$(jq 'length' <<< "$ADDRESS_LIST")

    AMOUNT_PER=$(awk "BEGIN{ print $3 / $COUNT }")

    if [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
        echo -n ""
    else    
        SEND_CONFIRM=$(cat <<EOF
==================================
         ${GREEN}CONFIRM DISBURSE${NC}
==================================
${GREEN}RECIPIENTS:${NC} $COUNT
${GREEN}AMOUNT PER:${NC} $AMOUNT_PER
${GREEN}FROM:${NC} $SRC
----------------------------------
${GREEN}BALANCE:${NC} $(raw_to_nano $CURRENT_BALANCE)
==================================
Press 'Y' to continue:
EOF
)
        read -p "$SEND_CONFIRM " SEND_CONFIRM_YES
        if [[ $SEND_CONFIRM_YES != 'y' ]] && [[ $SEND_CONFIRM_YES != 'Y' ]]; then
          echo "Canceled."
          exit 0
        fi
    fi

    index=1

    for item in "${my_array[@]}"; do

        if [[ "$item" == *"nano_"* ]]; then

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
    "destination": "$(echo "$item" | tr -d '"')",
    "amount": "$(nano_to_raw $AMOUNT_PER)",
    "id": "$(uuidgen)",
    "work": "$WORK"
}
EOF
))          

            sleep 0.1s

            let "index++"

        fi

    done

    exit 0
    
}


if [[ $1 == "disburse" ]] || [[ $1 == "faucet" ]] || [[ $1 == "distribute" ]]; then

    disburse $1 $2 $3 $4 $5

    exit 0

fi



function send_with_pow() {

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
      NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $1 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing To. Usage 'n2 send_with_pow [to] [amount_raw] [from] [work]'"
        exit 0
    fi
    
    if [[ $2 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing Amount. Use 'all' to send entire balance."
        exit 0
    fi

    if [[ $3 == "" ]]; then
        echo "${CYAN}Node${NC}: Missing From. Usage 'n2 send_with_pow [to] [amount_raw] [from] [work]'"
        exit 0
    fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    SEND_ATTEMPT=$(curl -s '[::1]:7076' \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "send",
    "wallet": "$WALLET_ID",
    "source": "$3",
    "destination": "$1",
    "amount": "$2",
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



# Sorta working
if [[ "$1" = "vanity" ]]; then

    if [[ ! -f "$DIR/.cargo/bin/nano-vanity" ]]; then

        INSTALL_NOTE=$(cat <<EOF
==================================
    ${GREEN}@PlasmaPower/Nano-Vanity${NC}
==================================
Press 'Y' to install:
EOF
)
        read -p "$INSTALL_NOTE " YES
    
        # read -p ' not installed. Enter 'Y' to install: ' YES

        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then

            if ! [ -x "$(command -v cargo)" ]; then
                sudo apt install ocl-icd-opencl-dev gcc make build-essential -y
                curl https://sh.rustup.rs -sSf | sh
                source $DIR/.cargo/env
            fi
            
            # cargo install nano-vanity
            git clone https://github.com/PlasmaPower/nano-vanity.git
            cargo install --path .
            rm -rf nano-vanity

            echo "=============================="
            echo "Done. You may need to restart SSH session."
            echo "=============================="

        else 
            echo "Canceled"
            exit 0
        fi

    fi

    if [[ -z "$2" ]]; then
        echo "${RED}Error:${NC} Missing Vanity Phrase."
        exit 0
    fi

    VANITY_PATH="$DIR/.cargo/bin/nano-vanity"

    if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]]; then

        GPU_INSTALLED=$(lspci -vnnn | perl -lne 'print if /^\d+\:.+(\[\S+\:\S+\])/' | grep VGA)

        if [[ $GPU_INSTALLED == *"paravirtual"* ]]; then
            THREAD_COUNT=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
            USE_THREAD_COUNT=$(awk "BEGIN {print ($THREAD_COUNT - 1) }")
            VANITY_ADDRESS=$($VANITY_PATH $2 --no-progress --threads $USE_THREAD_COUNT --simple-output)
        else 
            VANITY_ADDRESS=$($VANITY_PATH $2 --no-progress --gpu-device 0 --gpu-platform 0 --simple-output)
        fi

        VANITY_ADDRESS_ARRAY=($VANITY_ADDRESS)

        if [[ ${VANITY_ADDRESS_ARRAY[1]} == *"nano_"* ]]; then
            VANITY_JSON="{ \"public\": \"${VANITY_ADDRESS_ARRAY[1]}\", \"private\": \"${VANITY_ADDRESS_ARRAY[0]}\"  }"
            echo $VANITY_JSON
        else
            echo "{ \"error\": \"$VANITY_PATH $2 --no-progress --threads $USE_THREAD_COUNT --simple-output\"  }"
        fi

    else 

        if [[ $GPU_INSTALLED == *"paravirtual"* ]]; then
            THREAD_COUNT=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
            USE_THREAD_COUNT=$(awk "BEGIN {print ($THREAD_COUNT - 1) }")
            VANITY_ADDRESS=$($VANITY_PATH $2 --threads $USE_THREAD_COUNT)
        else 
            VANITY_ADDRESS=$($VANITY_PATH $2 --gpu-device 0 --gpu-platform 0)
        fi

        echo $VANITY_ADDRESS

    fi

    exit 0

fi

if [[ "$1" = "pow" ]]; then

    if [[ -z "$2" ]]; then
        echo "${RED}Error:${NC} Missing second paramerter. Fronteir Hash."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    POW_ATTEMPT=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "work_generate",
    "hash": "$2",
    "use_peers": "true"
}
EOF
  ))

    echo $POW_ATTEMPT
    
    exit 0

fi


if [[ "$1" = "receive" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
        NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    # if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
    #   echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
    #   exit 0
    # else
    #   NODE_PATH=$(cat $DIR/.n2/path)
    # fi

    if [[ $(cat $DIR/.n2/wallet 2>/dev/null) == "" ]]; then
        WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )
        echo $WALLET_ID > $DIR/.n2/wallet
    else
        WALLET_ID=$(cat $DIR/.n2/wallet)
    fi

    accounts_on_file=$(get_accounts)

    if [[ -z "$2" ]]; then
        ACCOUNT_INDEX="0"
    else
        ACCOUNT_INDEX=$(expr $2 - 1)
    fi

    ACCOUNT=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 

    RECEIVE_RPC=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
  "action": "receivable",
  "account": "$ACCOUNT",
  "count": "100"
}
EOF
  ))

#     RECEIVE_RPC=$(curl -s $NODE_URL \
#     -H "Accept: application/json" \
#     -H "Content-Type:application/json" \
#     --request POST \
#     --data @<(cat <<EOF
# {
#   "action": "receive",
#   "wallet": "$WALLET_ID",
#   "account": "$ACCOUNT",
#   "block": "1A6E00F7F68EA08236A00EC30E1B4C2DFDB5DD74FF6C6E59FE46D8DFF2DA6A11"
# }
# EOF
#   ))

   echo $RECEIVE_RPC

    exit 0

fi


if [[ "$1" = "version" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
         NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    NODE_VERSION=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "version"
}
EOF
  ))

   echo $NODE_VERSION

  exit 0

fi


if [[ "$1" = "block_count" ]] || [[ "$1" = "count" ]] || [[ "$1" = "blocks" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
         NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    NODE_VERSION=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "version"
}
EOF
  ))

  NODE_SYNC=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "block_count"
}
EOF
  ))

  echo $NODE_SYNC

  exit 0

fi

if [[ "$1" = "sync" ]] || [[ "$1" = "status" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
         NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        echo -n ""
    else
        echo "${RED}Error:${NC} ${CYAN}Node offline.${NC} Use 'n2 setup' for more information."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    NODE_VERSION=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "version"
}
EOF
  ))

  NODE_SYNC=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "block_count"
}
EOF
  ))

  NODE_BLOCK_COUNT=$(jq '.count' <<< "$NODE_SYNC" | tr -d '"') 
  NODE_BLOCK_UNCHECKED=$(jq '.unchecked' <<< "$NODE_SYNC" | tr -d '"') 
  NODE_BLOCK_CEMENTED=$(jq '.cemented' <<< "$NODE_SYNC" | tr -d '"') 

  INT_NODE_BLOCK_COUNT=$(expr $NODE_BLOCK_COUNT + 0)
  INT_NODE_BLOCK_UNCHECKED=$(expr $NODE_BLOCK_UNCHECKED + 0)
  INT_NODE_BLOCK_CEMENTED=$(expr $NODE_BLOCK_CEMENTED + 0)

  SYNC_PERCENT=$(awk "BEGIN {print  (($INT_NODE_BLOCK_COUNT - $INT_NODE_BLOCK_UNCHECKED) / $INT_NODE_BLOCK_COUNT) * 100 }")

  echo "{ \"sync\": \"$SYNC_PERCENT%\", \"block_count\": \"$NODE_BLOCK_COUNT\", \"unchecked\": \"$NODE_BLOCK_UNCHECKED\", \"cemented\": \"$NODE_BLOCK_CEMENTED\" }"

  exit 0

fi

if [[ "$1" = "node" ]] && [[ "$2" = "start" ]] || [[ "$1" = "start" ]] || [[ "$1" = "up" ]]; then
    
    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    cd $NODE_PATH && docker-compose start nano-node > /dev/null

    exit 0

fi

if [[ "$1" = "unlock" ]]; then
    
    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    sed -i 's/enable_control = false/enable_control = true/g' "$NODE_PATH/nano-node/Nano/config-rpc.toml"

    exit 0

fi

if [[ "$1" = "lock" ]]; then
    
    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    sed -i 's/enable_control = true/enable_control = false/g' "$NODE_PATH/nano-node/Nano/config-rpc.toml"

    exit 0

fi


if [[ "$1" = "node" ]] && [[ "$2" = "stop" ]] || [[ "$1" = "stop" ]] || [[ "$1" = "down" ]]; then
    
    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    cd $NODE_PATH && docker-compose stop nano-node > /dev/null

    exit 0

fi


if [[ "$1" = "setup" ]] || [[ "$1" = "--setup" ]] || [[ "$1" = "install" ]] || [[ "$1" = "i" ]]; then

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo -n ""
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "${CYAN}Node${NC}: You're on a Mac. OS not supported. Use an Ubuntu server instead."
        exit 0
      # Mac OSX
    else
        echo "${CYAN}Node${NC}: Operating system not supported."
        exit 0
    fi

    if [[ -z "$2" ]]; then
        echo "${GREEN}Available Packages${NC}:"
        echo "$ n2 $1 node"
        echo "$ n2 $1 vanity"
        echo "$ n2 $1 pow-server"
        echo "$ n2 $1 gpu-driver"
        exit 0
    fi

    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not provided.${NC} Use 'n2 config path PATH'. You will need ~200GB of space."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
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
    if [[ "$2" = "work-server" ]] || [[ "$2" = "work" ]]; then
        
        read -p 'Setup Nano Work Server. Enter 'y' to continue: ' YES

        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then

            if ! [ -x "$(command -v cargo)" ]; then
                sudo apt install ocl-icd-opencl-dev gcc build-essential -y
                curl https://sh.rustup.rs -sSf | sh
                source $DIR/.cargo/env
            fi
            
            git clone https://github.com/nanocurrency/nano-work-server.git $DIR/nano-work-server
            cd $DIR/nano-work-server && cargo build --release

            sudo crontab -l > cronjob
            #echo new cron into cron file
            echo "@reboot $DIR/nano-work-server/target/release/nano-work-server --gpu 0:0 -l [::1]:7078" >> cronjob
            #install new cron file
            sudo crontab cronjob
            rm cronjob

            exit 0
        fi

        echo "Canceled"
        exit 0

    fi

    if [[ "$2" = "gpu" ]] || [[ "$2" = "gpu-driver" ]] || [[ "$2" = "gpu-drivers" ]]; then
        
        read -p 'Setup NVIDIA Drivers. Enter 'Y' to continue: ' YES

        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            
            # GPU
            apt install ubuntu-drivers-common
            sudo apt-get purge nvidia*
            sudo ubuntu-drivers autoinstall

            exit 0
        fi

        echo "Canceled"
        exit 0

    fi


    if [[ "$2" = "node" ]]; then
        INSTALL_NOTE=$(cat <<EOF
==================================
         ${GREEN}Setup New Node${NC}
==================================
${GREEN}CPU${NC}:>=4${GREEN} RAM${NC}:>=4GB${GREEN} SSD${NC}:>=500GB
==================================
Press 'Y' to continue:
EOF
)
        read -p "$INSTALL_NOTE " YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            echo "${RED}N2${NC}: 1-Click Nano Node Coming Soon."
            # https://github.com/fwd/nano-docker
            # curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
            # cd $DIR && git clone https://github.com/fwd/nano-docker.git
            # LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
            # cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
            exit 0
        fi
        echo "Canceled"
        exit 0
    fi


fi



# ██╗  ██╗███████╗██╗     ██████╗ 
# ██║  ██║██╔════╝██║     ██╔══██╗
# ███████║█████╗  ██║     ██████╔╝
# ██╔══██║██╔══╝  ██║     ██╔═══╝ 
# ██║  ██║███████╗███████╗██║     
# ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     

if [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-help" ] || [ "$1" = "-h" ]; then
    echo "$DOCS"
    exit 0
fi

# ██╗   ██╗███████╗██████╗ ███████╗██╗ ██████╗ ███╗   ██╗
# ██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔═══██╗████╗  ██║
# ██║   ██║█████╗  ██████╔╝███████╗██║██║   ██║██╔██╗ ██║
# ╚██╗ ██╔╝██╔══╝  ██╔══██╗╚════██║██║██║   ██║██║╚██╗██║
#  ╚████╔╝ ███████╗██║  ██║███████║██║╚██████╔╝██║ ╚████║
#   ╚═══╝  ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝                                      

if [[ "$1" = "v" ]] || [[ "$1" = "-v" ]] || [[ "$1" = "--version" ]] || [[ "$1" = "version" ]]; then

    if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
         NODE_URL='[::1]:7076'
        echo $NODE_URL > $DIR/.n2/node
    else
        NODE_URL=$(cat $DIR/.n2/node)
    fi

    if curl -sL --fail $NODE_URL -o /dev/null; then
        
NODE_VERSION=$(curl -s $NODE_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "version"
}
EOF
  ))

    echo "${GREEN}NANO NODE:${NC} N2 $(jq '.node_vendor' <<< "$NODE_VERSION" | tr -d '"')"
    echo "${GREEN}N2 CLI:${NC} N2 $VERSION"

    else
        echo "${GREEN}N2 CLI:${NC} N2 $VERSION"
    fi

    exit 0

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
        echo "${GREEN}N2${NC}: Installed latest development version."
        exit 0
    fi
    if [ "$2" = "--prod" ] || [ "$2" = "prod" ]; then
        sudo rm /usr/local/bin/n2
        curl -s -L "https://github.com/fwd/n2/raw/master/n2.sh" -o /usr/local/bin/n2
        sudo chmod +x /usr/local/bin/n2
        echo "${GREEN}N2${NC}: Installed N2 $VERSION."
        exit 0
    fi
    curl -s -L "https://github.com/fwd/n2/raw/master/n2.sh" -o /usr/local/bin/n2
    sudo chmod +x /usr/local/bin/n2
    echo "${GREEN}N2${NC}: Installed N2 $VERSION."
    exit 0
fi

# ██╗   ██╗███╗   ██╗██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
# ██║   ██║████╗  ██║██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
# ██║   ██║██╔██╗ ██║██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
# ██║   ██║██║╚██╗██║██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
# ╚██████╔╝██║ ╚████║██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
#  ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝

if [[ "$1" = "--uninstall" ]] || [[ "$1" = "-u" ]]; then
    sudo rm /usr/local/bin/n2
    rm $DIR/.n2/wallet
    rm $DIR/.n2/accounts
    rm $DIR/.n2/cache
    rm -rf $DIR/.n2/data
    echo "CLI removed. Thanks for using N2. Hope to see you soon."
    exit 0
fi

# ██╗  ██╗██╗   ██╗██╗  ██╗
# ██║  ██║██║   ██║██║  ██║
# ███████║██║   ██║███████║
# ██╔══██║██║   ██║██╔══██║
# ██║  ██║╚██████╔╝██║  ██║
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                         
cat <<EOF
Commant not found. Use 'n2 help' to list commands.
EOF

exit 0
