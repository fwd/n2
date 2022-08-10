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