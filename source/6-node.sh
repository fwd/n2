

if [[ "$2" = "setup" ]] || [[ "$2" = "--setup" ]] || [[ "$2" = "install" ]]; then

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo ""
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "${CYAN}Node${NC}: You're on a Mac. OS not supported. Try a Cloud server running Ubuntu."
        sponsor
        exit 0
      # Mac OSX
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
      # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
      # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
      # I'm not sure this can happen.
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
      # ...
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
    else
       # Unknown.
        echo "${CYAN}Node${NC}: Operating system not supported."
        sponsor
        exit 0
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
    if [[ "$2" = "gpu" ]] || [[ "$2" = "--gpu" ]]; then
        read -p 'Setup NVIDIA GPU. Enter 'y' to continue: ' YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            sudo apt-get purge nvidia*
            sudo ubuntu-drivers autoinstall
            exit 0
        fi
        echo "Canceled"
        exit 0
    fi

    read -p 'Attempt to setup a Nano Node: Enter 'y': ' YES
    if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
        # https://github.com/fwd/nano-docker
        curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
        # cd $DIR && git clone https://github.com/fwd/nano-docker.git
        # LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
        # cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
        exit 0
    fi
    echo "Canceled"
    exit 0

fi


