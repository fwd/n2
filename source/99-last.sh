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