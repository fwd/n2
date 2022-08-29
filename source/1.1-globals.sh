

function get_accounts() {

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
    echo "${RED}Error:${NC} ${CYAN}Node not found.${NC} Use 'n2 setup' for more information."
    exit 0
  fi

  if [[ $(cat $DIR/.n2/node 2>/dev/null) == "" ]]; then
      NODE_URL='[::1]:7076'
      echo $NODE_URL >> $DIR/.n2/node
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
  accounts_on_file=$(get_accounts)
  if [[ "$1" == "--json" ]] || [[ "$1" == "--json" ]]; then
      echo $(jq '.accounts' <<< "$accounts_on_file")
      exit 0
  fi
  readarray -t my_array < <(jq '.accounts' <<< "$accounts_on_file")
  index=1
  for item in "${my_array[@]}"; do
    if [[ "$item" == *"nano_"* ]]; then
      if [[ "$1" == "--show" ]] || [[ "$2" == "--show" ]]; then
      echo "[$index]:" $item | tr -d '"'
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
  first_account=$(jq ".accounts[$ACCOUNT_INDEX]" <<< "$accounts_on_file" | tr -d '"') 
  # fi

  echo $first_account

}


function print_balance() {

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

  # echo $first_account

  # exit 0

  account_info=$(get_balance "$first_account")

  if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
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

  balance_in_decimal=$(curl -s "https://api.nano.to/convert/fromRaw/$account_balance" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)
  
  # echo $account_pending
  balance_in_decimal_value=$(jq '.value' <<< "$balance_in_decimal" | tr -d '"') 
  # exit 1

  if [[ $account_pending == "0" ]]; then
    echo -n ""
    pending_in_decimal_value="0"
  else 
    pending_in_decimal=$(curl -s "https://api.nano.to/convert/fromRaw/$account_pending" \
      -H "Accept: application/json" \
      -H "Content-Type:application/json" \
      --request GET)
    pending_in_decimal_value=$(jq '.value' <<< "$pending_in_decimal" | tr -d '"') 
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

  # echo $NODE_SYNC

  NODE_BLOCK_COUNT=$(jq '.count' <<< "$NODE_SYNC" | tr -d '"') 
  NODE_BLOCK_UNCHECKED=$(jq '.unchecked' <<< "$NODE_SYNC" | tr -d '"') 
  NODE_BLOCK_CEMENTED=$(jq '.cemented' <<< "$NODE_SYNC" | tr -d '"') 

  INT_NODE_BLOCK_COUNT=$(expr $NODE_BLOCK_COUNT + 0)
  INT_NODE_BLOCK_UNCHECKED=$(expr $NODE_BLOCK_UNCHECKED + 0)
  INT_NODE_BLOCK_CEMENTED=$(expr $NODE_BLOCK_CEMENTED + 0)

  # echo $INT_NODE_BLOCK_COUNT
  # echo $INT_NODE_BLOCK_UNCHECKED
  # echo $INT_NODE_BLOCK_CEMENTED

  # Let's say you have two numbers, $INT_NODE_BLOCK_COUNT and $INT_NODE_BLOCK_UNCHECKED.  

  # $INT_NODE_BLOCK_UNCHECKED / $INT_NODE_BLOCK_COUNT * 100 = 75.
  # So $INT_NODE_BLOCK_UNCHECKED is 75% of $INT_NODE_BLOCK_COUNT. 

  SYNC_PERCENT=$(awk "BEGIN {print  (($INT_NODE_BLOCK_COUNT - $INT_NODE_BLOCK_UNCHECKED) / $INT_NODE_BLOCK_COUNT) * 100 }")

  # string='My long string'
  if [[ $SYNC_PERCENT == *"99."* ]]; then
    FINAL_SYNC_PERCENT="100"
  else
    FINAL_SYNC_PERCENT=$SYNC_PERCENT
  fi

  echo "============================="
  echo "${GREEN}$CLI_TITLE${NC}"
  echo "============================="
  if [[ "$1" == "--hide" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "hide" ]]; then
    echo "${PURP}Address:${NC} $(echo "$first_account" | cut -c1-17)***"
  else
    echo "${PURP}Address:${NC} $(echo "$first_account" | cut -c1-17)***"
    # echo "${PURP}Address:${NC} $first_account***"
    echo "${PURP}Balance:${NC} $balance_in_decimal_value"
    echo "${PURP}Pending:${NC} $pending_in_decimal_value"
    echo "${PURP}Accounts:${NC} ${total_accounts}"
    # echo "${PURP}HashData:${NC} $metadata"
  fi
  echo "============================="
  echo "${PURP}Blockchain:${NC} ${GREEN}$(jq '.node_vendor' <<< "$NODE_VERSION" | tr -d '"') @ $FINAL_SYNC_PERCENT%${NC}"
  # echo "${PURP}Node Sync:${NC} ${GREEN}100%${NC}"
  # echo "${PURP}Node Uptime:${NC} 25 days"
  # echo "============================="
  echo "============================="
  # if [[ "$1" == "--hide" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "hide" ]]; then
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

if [[ $1 == "list" ]] || [[ $1 == "ls" ]]; then

    list_accounts $2 $3
    # ACCOUNT_LIST=$(jq '.accounts' <<< get_accounts) 

    # echo $(jq length <<< list_accounts)

    exit 0

fi
