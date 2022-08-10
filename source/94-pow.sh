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

