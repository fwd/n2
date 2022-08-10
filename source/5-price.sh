
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

