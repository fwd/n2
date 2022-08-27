

if [ "$2" = "download-ledger" ] || [ "$2" = "fast-sync" ] || [ "$2" = "--fs" ] || [ "$2" = "-fs" ] || [ "$2" = "-dl" ]; then

    TIMELINE='week'
    echo "================================="
    echo "       UNDER CONSTRUCTION        "
    echo "================================="
    echo "'n2 convert' is under development. Update N2 in a $TIMELINE or so. Tweet @nano2dev to remind me to get it done."
    echo "================================="
    echo "https://twitter.com/nano2dev"
    echo "================================="
    exit 0

    ledgerDownloadLink=$(curl -s 'https://s3.us-east-2.amazonaws.com/repo.nano.org/snapshots/latest')

    wget -O ledger.7z ${ledgerDownloadLink} -q --show-progress

    printf "=> ${yellow}Unzipping and placing files to /Nano (takes a while)...${reset} "

    7z x ledger.7z -o ./Nano -y &> /dev/null

    # rm ledger.7z
    
    # printf "${green}Done.${reset}\n"
    
    exit
fi

