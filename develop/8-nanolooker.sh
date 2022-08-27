
#  ██████╗██╗  ██╗ █████╗ ██╗███╗   ██╗
# ██╔════╝██║  ██║██╔══██╗██║████╗  ██║
# ██║     ███████║███████║██║██╔██╗ ██║
# ██║     ██╔══██║██╔══██║██║██║╚██╗██║
# ╚██████╗██║  ██║██║  ██║██║██║ ╚████║
#  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
                                    
if [ "$2" = "nanolooker" ] || [ "$2" = "--nl" ] || [ "$2" = "-nl" ] || [ "$2" = "-l" ]; then

    if [[ $(cat $DIR/.n2/session 2>/dev/null) == "" ]]; then
        echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
        exit 0
    fi

    ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
    -H "Accept: application/json" \
    -H "session: $(cat $DIR/.n2/session)" \
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


