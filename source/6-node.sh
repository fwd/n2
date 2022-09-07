
if [[ "$1" = "pow" ]]; then

    if [[ -z "$2" ]]; then
        echo "${RED}Error:${NC} Missing second paramerter. Fronteir Hash."
        exit 0
    fi

    if [[ $(cat $DIR/.n2/pow 2>/dev/null) == "" ]]; then
      POW_URL='[::1]:7090'
      echo $POW_URL >> $DIR/.n2/pow
    else
      POW_URL=$(cat $DIR/.n2/pow)
    fi

    POW_ATTEMPT=$(curl -s $POW_URL \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --request POST \
    --data @<(cat <<EOF
{
    "action": "work_generate",
    "hash": "$2"
}
EOF
  ))

    echo $POW_ATTEMPT
    
    exit 0

fi

if [[ "$1" = "node" ]] && [[ "$2" = "start" ]] ||  [[ "$1" = "start" ]]; then
    
    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    cd $NODE_PATH && docker-compose start nano-node > /dev/null

    exit 0

fi

if [[ "$1" = "node" ]] && [[ "$2" = "stop" ]] ||  [[ "$1" = "stop" ]]; then
    
    if [[ $(cat $DIR/.n2/path 2>/dev/null) == "" ]]; then
      echo "${RED}Error:${NC} ${CYAN}Node Path not setup.${NC} Use 'n2 config path PATH'."
      exit 0
    else
      NODE_PATH=$(cat $DIR/.n2/path)
    fi

    cd $NODE_PATH && docker-compose stop nano-node > /dev/null

    exit 0

fi


if [[ "$1" = "setup" ]] || [[ "$1" = "--setup" ]] || [[ "$1" = "install" ]] || [[ "$1" = "i" ]]; then

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo -n ""
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "${CYAN}Node${NC}: You're on a Mac. OS not supported. Try a Cloud server running Ubuntu."
        # sponsor
        exit 0
      # Mac OSX
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        # sponsor
        exit 0
      # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "${CYAN}Node${NC}: Operating system not supported."
        # sponsor
        exit 0
      # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
      # I'm not sure this can happen.
        echo "${CYAN}Node${NC}: Operating system not supported."
        # sponsor
        exit 0
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
      # ...
        echo "${CYAN}Node${NC}: Operating system not supported."
        # sponsor
        exit 0
    else
       # Unknown.
        echo "${CYAN}Node${NC}: Operating system not supported."
        # sponsor
        exit 0
    fi

    if [[ -z "$2" ]]; then
        echo "${GREEN}Available Packages${NC}:"
        echo "$ n2 $1 node"
        echo "$ n2 $1 vanity"
        echo "$ n2 $1 pow-server"
        echo "$ n2 $1 gpu-driver"
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
    if [[ "$2" = "work-server" ]] || [[ "$2" = "work" ]]; then
        
        read -p 'Setup Nano Work Server. Enter 'y' to continue: ' YES

        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then

            if ! [ -x "$(command -v cargo)" ]; then
                sudo apt install ocl-icd-opencl-dev gcc build-essential -y
                curl https://sh.rustup.rs -sSf | sh
                source $DIR/.cargo/env
            fi
            
            git clone https://github.com/nanocurrency/nano-work-server.git $DIR/nano-work-server
            cd $DIR/nano-work-server && cargo build --release

            sudo crontab -l > cronjob
            #echo new cron into cron file
            echo "@reboot $DIR/nano-work-server/target/release/nano-work-server --gpu 0:0 -l [::1]:7078" >> cronjob
            #install new cron file
            sudo crontab cronjob
            rm cronjob

            exit 0
        fi

        echo "Canceled"
        exit 0

    fi

    # Sorta working
    if [[ "$2" = "vanity" ]]; then
        
        read -p 'Setup Nano Vanity (RUST). Enter 'Y' to continue: ' YES

        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then

            if ! [ -x "$(command -v cargo)" ]; then
                sudo apt install ocl-icd-opencl-dev gcc build-essential -y
                curl https://sh.rustup.rs -sSf | sh
                source $DIR/.cargo/env
            fi
            
            # GPU
            cargo install nano-vanity

            exit 0
        fi

        echo "Canceled"
        
        exit 0

    fi

    if [[ "$2" = "gpu" ]] || [[ "$2" = "gpu-driver" ]] || [[ "$2" = "gpu-drivers" ]]; then
        
        read -p 'Setup NVIDIA Drivers. Enter 'Y' to continue: ' YES

        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            
            # GPU
            apt install ubuntu-drivers-common
            sudo apt-get purge nvidia*
            sudo ubuntu-drivers autoinstall

            exit 0
        fi

        echo "Canceled"
        exit 0

    fi


    if [[ "$2" = "node" ]]; then
        INSTALL_NOTE=$(cat <<EOF
==================================
         ${GREEN}Setup New Node${NC}
==================================
${GREEN}CPU${NC}:>=4${GREEN} RAM${NC}:>=4GB${GREEN} SSD${NC}:>=500GB
==================================
Press 'Y' to continue:
EOF
)
        read -p "$INSTALL_NOTE " YES
        if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
            echo "${RED}N2${NC}: 1-Click Nano Node Coming Soon."
            # https://github.com/fwd/nano-docker
            # curl -L "https://github.com/fwd/nano-docker/raw/master/install.sh" | sh
            # cd $DIR && git clone https://github.com/fwd/nano-docker.git
            # LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
            # cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
            exit 0
        fi
        echo "Canceled"
        exit 0
    fi


fi

