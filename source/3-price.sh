
# ██████╗ ██████╗ ██╗ ██████╗███████╗
# ██╔══██╗██╔══██╗██║██╔════╝██╔════╝
# ██████╔╝██████╔╝██║██║     █████╗  
# ██╔═══╝ ██╔══██╗██║██║     ██╔══╝  
# ██║     ██║  ██║██║╚██████╗███████╗
# ╚═╝     ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝                                  

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then

    if [[ -z $2 ]]; then
        FIAT=$2
    else  
        FIAT='usd'
    fi

    PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=nano&vs_currencies=$FIAT" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request GET)

    echo $(jq -r '.nano' <<< "$PRICE")

    exit 0

fi

