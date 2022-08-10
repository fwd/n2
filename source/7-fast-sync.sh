

if [ "$2" = "download-ledger" ] || [ "$2" = "fast-sync" ] || [ "$2" = "--fs" ] || [ "$2" = "-fs" ]; then

    ledgerDownloadLink=$(curl -s 'https://s3.us-east-2.amazonaws.com/repo.nano.org/snapshots/latest')

    wget -O ledger.7z ${ledgerDownloadLink} -q --show-progress

    printf "=> ${yellow}Unzipping and placing the files (takes a while)...${reset} "

    7z x ledger.7z -o ./Nano -y &> /dev/null

    # rm ledger.7z
    
    # printf "${green}Done.${reset}\n"
    
    exit
fi

