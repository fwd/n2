#!/bin/bash

###############################
## n2 Command Line Tool      ##
## (c) 2018-2022 @nano2dev   ##
## Released for MIT License  ##
###############################

# Install 'jq' if needed.
if ! command -v jq &> /dev/null; then
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install jq -y
	else
		echo "Error: We could not auto install 'jq'. Please install it manually, before continuing."
		exit 1
	fi
fi

# Install 'curl' if needed.
if ! command -v curl &> /dev/null; then
	# Really? What kind of rinky-dink machine is this.
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install curl -y
	else
		echo "Error: We could not auto install 'curl'. Please install it manually, before continuing."
		exit 1
	fi
fi

# VERSION: 0.2
# CODENAME: "FUZZY SLIPPERS"
VERSION=0.2

# GET HOME DIR
DIR=$(eval echo "~$different_user")
BANNER=$(cat <<'END_HEREDOC'

███╗   ██╗ █████╗ ███╗   ██╗ ██████╗ ████████╗ ██████╗ 
████╗  ██║██╔══██╗████╗  ██║██╔═══██╗╚══██╔══╝██╔═══██╗
██╔██╗ ██║███████║██╔██╗ ██║██║   ██║   ██║   ██║   ██║
██║╚██╗██║██╔══██║██║╚██╗██║██║   ██║   ██║   ██║   ██║
██║ ╚████║██║  ██║██║ ╚████║╚██████╔╝██╗██║   ╚██████╔╝
╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝    ╚═════╝ 
END_HEREDOC
)

DOCS=$(cat <<'END_HEREDOC'
Nano.to 
  $ n2 login
  $ n2 register
  $ n2 account
  $ n2 2factor
  $ n2 logout

Local Wallet (Non-Custodial)
  $ n2 local wallets
  $ n2 local send @esteban 0.1 
  $ n2 local qrcode
  $ n2 local receive
  $ n2 local create
  $ n2 local secret
  $ n2 local install
  $ n2 local upgrade
  $ n2 local plugins

Cloud Wallet (Custodial)
  $ n2 cloud balance
  $ n2 cloud send @esteban 0.1
  $ n2 cloud pow @esteban
  $ n2 cloud qrcode
  $ n2 cloud receive
  $ n2 cloud recycle

Cloud Services
  $ n2 price
  $ n2 stats

Options
  --help, -h  Print CLI Documentation.
  --docs, -d  Open Nano.to Documentation.
  --address, -a  Print you Nano address.
  --email, -e  Print your account email.
  --api, -k  Print CLI API KEY email.
  --update, -u  Get latest CLI Script.
  --version, -v  Print current CLI Version.
  --uninstall, -u  Remove CLI from system.
END_HEREDOC
)

# Nice



# ██╗      ██████╗  ██████╗ █████╗ ██╗     
# ██║     ██╔═══██╗██╔════╝██╔══██╗██║     
# ██║     ██║   ██║██║     ███████║██║     
# ██║     ██║   ██║██║     ██╔══██║██║     
# ███████╗╚██████╔╝╚██████╗██║  ██║███████╗
# ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝
                                                                                                                  
if [[ "$1" = "node" ]] || [[ "$1" = "local" ]]; then

	# rpc() {
	# 	SESSION=$(curl -s "$RPC" \
	# 	-H "Accept: application/json" \
	# 	-H "Content-Type:application/json" \
	# 	--request POST \
	# 	--data @<(cat <<EOF
	# { "action": "$2" }
	# EOF
	# 	))
	# 	echo $SESSION
	# }

	# LOCAL "NON-CUSTODIAL" WALLET, IS A WORK IN PROGRESS
	# BE A HERO, SEND A PULL REQUEST

	TIMELINE='year'
	
	echo "================================="
	echo "       UNDER CONSTRUCTION        "
	echo "================================="
	echo "'n2 local' is under development. Update N2 in a $TIMELINE or so. Tweet @nano2dev to remind me to get it done."
	echo "================================="
	echo "https://twitter.com/nano2dev"
	echo "================================="

	# rpc $2
	# curl -g -d '{ "$2": "$3" }' "$RPC"

cat <<EOF
Usage:
  $ n2 local balance
  $ n2 local send @esteban 0.1
  $ n2 local qrcode
  $ n2 local receive
  $ n2 local install
EOF
	
	exit 1
fi



# ███╗   ██╗ ██████╗ ██╗    ██╗
# ████╗  ██║██╔═══██╗██║    ██║
# ██╔██╗ ██║██║   ██║██║ █╗ ██║
# ██║╚██╗██║██║   ██║██║███╗██║
# ██║ ╚████║╚██████╔╝╚███╔███╔╝
# ╚═╝  ╚═══╝ ╚═════╝  ╚══╝╚══╝ 



# ███████╗███╗   ██╗████████╗███████╗██████╗ ██╗███╗   ██╗ ██████╗ 
# ██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔══██╗██║████╗  ██║██╔════╝ 
# █████╗  ██╔██╗ ██║   ██║   █████╗  ██████╔╝██║██╔██╗ ██║██║  ███╗
# ██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗██║██║╚██╗██║██║   ██║
# ███████╗██║ ╚████║   ██║   ███████╗██║  ██║██║██║ ╚████║╚██████╔╝
# ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
                                                      



# ███╗   ██╗ █████╗ ███╗   ██╗ ██████╗ ████████╗ ██████╗ 
# ████╗  ██║██╔══██╗████╗  ██║██╔═══██╗╚══██╔══╝██╔═══██╗
# ██╔██╗ ██║███████║██╔██╗ ██║██║   ██║   ██║   ██║   ██║
# ██║╚██╗██║██╔══██║██║╚██╗██║██║   ██║   ██║   ██║   ██║
# ██║ ╚████║██║  ██║██║ ╚████║╚██████╔╝██╗██║   ╚██████╔╝
# ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝    ╚═════╝ 
                                      


if [[ $1 == "cloud" ]]; then


if [[ $2 == "login" ]]; then

	echo "$BANNER"

	echo "Welcome back"

	echo

	USERNAME=$2
	PASSWORD=$3

	if [[ $USERNAME == "" ]]; then
		read -p 'Email: ' USERNAME
	fi

	if [[ $PASSWORD == "" ]]; then
		read -sp 'Password: ' PASSWORD
	fi

	LOGIN_ATTEMPT=$(curl -s "https://nano.to/login" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "username": "$USERNAME", "password": "$PASSWORD" }
EOF
	))

	if [[ $(jq -r '.two_factor' <<< "$LOGIN_ATTEMPT") == "true" ]]; then

		echo 
		echo 
		echo "========================"
		echo "   2-FACTOR REQUIRED    "
		echo "========================"
		echo

		read -sp 'Enter OTP Code: ' OTP_CODE

	LOGIN_ATTEMPT=$(curl -s "https://nano.to/login" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "username": "$USERNAME", "password": "$PASSWORD", "code": "$OTP_CODE" }
EOF
	))

	fi

	if [[ $(jq '.session' <<< "$LOGIN_ATTEMPT") == null ]]; then
		echo
		echo "Error:" $(jq -r '.message' <<< "$LOGIN_ATTEMPT")
		exit 1
	fi

	rm $DIR/.n2-session 2>/dev/null

	echo $(jq -r '.session' <<< "$LOGIN_ATTEMPT") >> $DIR/.n2-session

	echo

	echo "Ok. Logged in successfully."
	
	exit 1

fi

# ██████╗ ███████╗ ██████╗ ██╗███████╗████████╗███████╗██████╗ 
# ██╔══██╗██╔════╝██╔════╝ ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗
# ██████╔╝█████╗  ██║  ███╗██║███████╗   ██║   █████╗  ██████╔╝
# ██╔══██╗██╔══╝  ██║   ██║██║╚════██║   ██║   ██╔══╝  ██╔══██╗
# ██║  ██║███████╗╚██████╔╝██║███████║   ██║   ███████╗██║  ██║
# ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
                                                             
if [[ $2 == "register" ]]; then

	echo "$BANNER"

	echo 

	echo 'Welcome to the Cloud'

	echo 
	 
	read -p 'Email: ' USERNAME
	read -sp 'Password: ' PASSWORD
	 
	echo 
	# echo "Thank you $username for showing interest in learning with www.tutorialkart.com"

	REGISTER_ATTEMPT=$(curl -s "https://nano.to/register" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "username": "$USERNAME", "password": "$PASSWORD" }
EOF
	))

	if [[ $(jq '.session' <<< "$REGISTER_ATTEMPT") == null ]]; then
		echo
		echo "Error:" $(jq -r '.message' <<< "$REGISTER_ATTEMPT")
		exit 1
	fi

	rm $DIR/.n2-session 2>/dev/null

	echo $(jq -r '.session' <<< "$REGISTER_ATTEMPT") >> $DIR/.n2-session

	echo

	echo "Ok. Logged in successfully."
	
	exit 1

fi


# ██████╗       ███████╗ █████╗ 
# ╚════██╗      ██╔════╝██╔══██╗
#  █████╔╝█████╗█████╗  ███████║
# ██╔═══╝ ╚════╝██╔══╝  ██╔══██║
# ███████╗      ██║     ██║  ██║
# ╚══════╝      ╚═╝     ╚═╝  ╚═╝                      

if [[ "$2" = "2f-enable" ]] || [[ "$2" = "2f" ]] || [[ "$2" = "2factor" ]] || [[ "$2" = "2fa" ]] || [[ "$2" = "-2f" ]] || [[ "$2" = "--2f" ]] || [[ "$2" = "--2factor" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: Not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	HAS_TWO_FACTOR=$(curl -s "https://nano.to/cli/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
	--request GET | jq '.two_factor')

	if [[ $HAS_TWO_FACTOR == "true" ]]; then
		echo "Ok. 2-factor enabled. Use 'n2 2f-remove' to change 2-factor."
		exit 1
	fi

	NEW_SETUP=$(curl -s "https://nano.to/user/two-factor" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
	--request GET)

	OTP_ID=$(jq -r '.id' <<< "$NEW_SETUP")
	QR=$(jq -r '.qr' <<< "$NEW_SETUP")
	KEY=$(jq -r '.key' <<< "$NEW_SETUP")

	echo "==============================="
	echo "        ENABLE 2-FACTOR        "
	echo "==============================="
	echo "Copy the 'KEY' or scan the provided QR."
	echo "==============================="
	echo "NAME: Nano.to"
	echo "KEY:" $KEY
	echo "QR:" $QR
	echo "==============================="
	read -p 'First OTP Code: ' FIRST_OTP

	if [[ $FIRST_OTP == "" ]]; then
		echo "Error: No code. Try again, but from scratch."
		exit 1
	fi

	OTP_ATTEMPT=$(curl -s "https://nano.to/user/two-factor" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "id": "$OTP_ID", "code": "$FIRST_OTP" }
EOF
	))

	echo 

	echo "$OTP_ATTEMPT"

	exit 1

fi

# STILL 2-FACTOR

if [[ "$2" = "2f-disable" ]] || [[ "$2" = "2f-remove" ]]; then

	HAS_TWO_FACTOR=$(curl -s "https://nano.to/cli/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
	--request GET | jq '.two_factor')

	if [[ $HAS_TWO_FACTOR == "false" ]]; then
		echo "Error: You don't have 2f enabled. Use 'n2 2f' to enable it."
		exit 1
	fi

	echo "========================"
	echo "    REMOVE 2-FACTOR     "
	echo "========================"
	echo
	echo "Please provide an existing OTP code."
	echo

	read -p 'Enter OTP Code: ' REMOVE_OTP

	if [[ $REMOVE_OTP == "" ]]; then
		echo "Error: No code. Try again, but from scratch."
		exit 1
	fi

	REMOVE_OTP_ATTEMPT=$(curl -s "https://nano.to/user/two-factor/disable" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "code": "$REMOVE_OTP" }
EOF
	))

	echo 

	echo "$REMOVE_OTP_ATTEMPT"

	exit 1

fi


# ██╗    ██╗██╗  ██╗ ██████╗ ██╗███████╗
# ██║    ██║██║  ██║██╔═══██╗██║██╔════╝
# ██║ █╗ ██║███████║██║   ██║██║███████╗
# ██║███╗██║██╔══██║██║   ██║██║╚════██║
# ╚███╔███╔╝██║  ██║╚██████╔╝██║███████║
#  ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚══════╝                                                                  

if [ "$2" = "whois" ] || [ "$2" = "search" ] || [ "$2" = "name" ] || [ "$2" = "username" ] || [ "$2" = "-w" ] || [ "$2" = "-f" ]; then

	# AWARD FOR CLEANEST METHOD
	WHOIS=$(curl -s "https://nano.to/$2/account" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
		echo $POW
		exit 1
	fi

	WALLETS=$(jq -r '.accounts' <<< "$WHOIS")

	# echo
	echo "==============================="
	echo "         WHOIS LOOKUP          "
	echo "==============================="
	echo "BALANCE: " $(jq -r '.balance' <<< $WHOIS)
	echo "ADDRESS: " $(jq -r '.address' <<< $WHOIS)
	echo "USERNAME: " $(jq -r '.username' <<< $WHOIS) 
	echo "BLOCKS: " $(jq -r '.height' <<< $WHOIS)
	echo "NANOLOOKER: https://nanolooker.com/account/"$(jq -r '.address' <<< $WHOIS)
	echo "==============================="

	exit 1

fi

# In Case Of
# ██╗  ██╗██╗████████╗    ██████╗ ██╗   ██╗    ██████╗ ██╗   ██╗███████╗███████╗
# ██║  ██║██║╚══██╔══╝    ██╔══██╗╚██╗ ██╔╝    ██╔══██╗██║   ██║██╔════╝██╔════╝
# ███████║██║   ██║       ██████╔╝ ╚████╔╝     ██████╔╝██║   ██║███████╗███████╗
# ██╔══██║██║   ██║       ██╔══██╗  ╚██╔╝      ██╔══██╗██║   ██║╚════██║╚════██║
# ██║  ██║██║   ██║       ██████╔╝   ██║       ██████╔╝╚██████╔╝███████║███████║
# ╚═╝  ╚═╝╚═╝   ╚═╝       ╚═════╝    ╚═╝       ╚═════╝  ╚═════╝ ╚══════╝╚══════╝                 

if [ "$2" = "secret" ] || [ "$2" = "--seed" ]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: Not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	echo 
	echo "========================"
	echo "   2-FACTOR REQUIRED    "
	echo "========================"
	echo

	read -sp 'Enter OTP Code: ' OTP_CODE

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
	rm $DIR/.n2-session
	echo
	echo "==============================="
	echo "    LOGGED OUT FOR SECURITY    "
	echo "==============================="
	echo "Use 'n2 login' to log back in. "
	echo "==============================="
	echo
	exit 1
	fi

	ADDRESS=$(jq -r '.address' <<< "$ACCOUNT")

	# AWARD FOR CLEANEST METHOD
	KEY=$(curl -s "https://nano.to/cli/$ADDRESS/seed?code=$OTP_CODE" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.error' <<< "$KEY") == "true" ]]; then
		echo
		echo $(jq -r '.message' <<< "$KEY")
		exit 1
	fi

	if [[ $(jq -r '.error' <<< "$KEY") == "429" ]]; then
		echo
		echo $(jq -r '.message' <<< "$KEY")
		exit 1
	fi
	
	echo
	echo "==============================="
	echo "       KEEP THIS SECURE        "
	echo "==============================="
	echo "PUBLIC: "$ADDRESS
	echo "SECRET: "$KEY

	exit 1

fi


#  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗ ██████╗ ██╗   ██╗████████╗
# ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝
# ██║     ███████║█████╗  ██║     █████╔╝ ██║   ██║██║   ██║   ██║   
# ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ██║   ██║██║   ██║   ██║   
# ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗╚██████╔╝╚██████╔╝   ██║   
#  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝                                                                 

if [ "$2" = "checkout" ] || [ "$2" = "--checkout" ] || [ "$2" = "-checkout" ] || [ "$2" = "c" ] || [ "$2" = "-c" ]; then

	if [[ $2 == "" ]]; then
		# read -p 'To (@Username or Address): ' $2
		echo "Error: Username, or Address missing."
		exit 1
	fi

	if [[ $3 == "" ]]; then
		# read -p 'Amount: ' $3
		echo "Error: Amount missing."
		exit 1
	fi

	CHECKOUT=$(curl -s "https://nano.to/$2?cli=$3" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET | jq -r '.qrcode')

	echo 

cat <<EOF
$CHECKOUT
EOF

	echo 

	exit 1

fi




# ███████╗████████╗ ██████╗ ██████╗ ███████╗
# ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
# ███████╗   ██║   ██║   ██║██████╔╝█████╗  
# ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝  
# ███████║   ██║   ╚██████╔╝██║  ██║███████╗
# ╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝

if [[ $2 == "purchase" ]] || [[ $2 == "store" ]] || [[ $2 == "buy" ]] || [[ $2 == "add" ]] || [[ $2 == "shop" ]] || [[ $2 == "--store" ]] || [[ $2 == "--shop" ]] || [[ $2 == "-s" ]]; then

	if [[ $2 == "" ]]; then
cat <<EOF

███████╗██╗  ██╗ ██████╗ ██████╗ 
██╔════╝██║  ██║██╔═══██╗██╔══██╗
███████╗███████║██║   ██║██████╔╝
╚════██║██╔══██║██║   ██║██╔═══╝ 
███████║██║  ██║╚██████╔╝██║     
╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝                                                  
EOF

		echo "================================="
		echo "          NANO.TO SHOP           "
		echo "================================="
		echo "address ------------------- Ӿ 0.1"
		echo "pow ---------------------- Ӿ 0.01"
		echo "================================="
		echo "Usage: 'n2 shop [name] [amount]'"
		echo "================================="

		echo 

		exit 1
	fi

	# if [[ $2 == "address" ]] || [[ $2 == "addresses" ]] || [[ $2 == "wallets" ]] || [[ $2 == "accounts" ]]; then
	# 	echo "================================="
	# 	echo "       UNDER CONSTRUCTION        "
	# 	echo "================================="
	# 	echo "Yeah, I bet you want multiple addresses with a single account. Imagine all the things you can build. Tweet @nano2dev and remind me to get it done."
	# 	echo "================================="
	# 	echo "https://twitter.com/nano2dev"
	# 	echo "================================="
	# 	exit 1
	# fi
	if [[ $2 == "address" ]] || [[ $2 == "addresses" ]] || [[ $2 == "wallets" ]] || [[ $2 == "accounts" ]]; then
		if [[ $3 == "" ]]; then
			echo "Missing amount to purchase. Usage: 'n2 add address 2'"
			exit 1
		fi
curl -s "https://nano.to/cli/shop/address" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "amount": "$3" }
EOF
	)
		echo
		exit 1
	fi

	if [[ $2 == "pow" ]]; then
		if [[ $3 == "" ]]; then
			echo "Missing amount to purchase. Usage: 'n2 add pow 5'"
			exit 1
		fi
curl -s "https://nano.to/cli/shop/pow" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "amount": "$3" }
EOF
	)
		echo
		exit 1
	fi

	echo "We don't sell that. Use 'n2 shop' to see list."

	exit 1

fi



# ██████╗  ██████╗ ██╗    ██╗
# ██╔══██╗██╔═══██╗██║    ██║
# ██████╔╝██║   ██║██║ █╗ ██║
# ██╔═══╝ ██║   ██║██║███╗██║
# ██║     ╚██████╔╝╚███╔███╔╝
# ╚═╝      ╚═════╝  ╚══╝╚══╝ 
                           
if [[ $2 == "pow" ]] || [[ $2 == "--pow" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
	rm $DIR/.n2-session
	echo
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
	-H "Authorization: $API_KEY" \
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

	echo $(jq -r '.work' <<< "$POW")

	exit 1

fi



# ███████╗███████╗███╗   ██╗██████╗ 
# ██╔════╝██╔════╝████╗  ██║██╔══██╗
# ███████╗█████╗  ██╔██╗ ██║██║  ██║
# ╚════██║██╔══╝  ██║╚██╗██║██║  ██║
# ███████║███████╗██║ ╚████║██████╔╝
# ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝                                   

if [[ $2 == "send" ]]; then

	# USERNAME=$2
	# AMOUNT=$3
	# FROM=$4
	# NOTE=$5

	if [[ $2 == "" ]]; then
		echo "Error: Missing @Username or Nano Address"
		exit 1
		# read -p 'To (@Username or Address): ' USERNAME
	fi
	
	if [[ $3 == "" ]]; then
		echo "Error: Missing amount. Use 'all' to send balance."
		exit 1
		# read -p 'Amount: ' AMOUNT
	fi

	# if [[ $4 == "" ]]; then
		# echo "Default: Sending from Master wallet."
		# echo "Error: Missing from. Use 'default' to use master wallet."
		# exit 1
		# read -p 'Amount: ' AMOUNT
	# fi

	# if [[ $4 == "" ]]; then
	# 	read -p 'Note (Optional): ' NOTE
	# fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)
	
  ADDRESS=$(jq -r '.address' <<< "$ACCOUNT")
  FRONTIER=$(jq -r '.frontier' <<< "$ACCOUNT")

	POW=$(curl -s "https://nano.to/$FRONTIER/pow" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.error' <<< "$POW") == "429" ]]; then
	echo
	echo "==============================="
	echo "       USED ALL CREDITS        "
	echo "==============================="
	echo "  Use 'n2 add pow' or wait.    "
	echo "==============================="
	echo
	exit 1
	fi

	# echo $POW
	# exit 1
	WORK=$(jq -r '.work' <<< "$POW")

	SEND=$(curl -s "https://nano.to/cli/send" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "to": "$2", "amount": "$3", "from": "$4", "note": "$5", "work": "$WORK" }
EOF
	))

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
		echo $SEND
		exit 1
	fi

	ERROR=$(jq -r '.error' <<< "$SEND")

	if [[ $ERROR = "429" ]]; then
	echo
	echo "===================================="
	echo "                ERROR               "
	echo "===================================="
	echo "You used up all your PoW credits.   "
	echo "Buy more with 'n2 add pow' or wait. "
	echo "===================================="
	echo
	exit 1
	fi

	hash=$(jq -r '.hash' <<< "$SEND")
	amount=$(jq -r '.amount' <<< "$SEND")
	hash_url=$(jq -r '.hash_url' <<< "$SEND")
	nanolooker=$(jq -r '.nanolooker' <<< "$SEND")
	duration=$(jq -r '.duration' <<< "$SEND")

	if [[ $ERROR == "Bad link number" ]]; then
	echo
	echo "================================"
	echo "           ERROR #100           "
	echo "================================"
	echo "Bad Address. Fix and try again. "
	echo "================================"
	echo
	exit 1
	fi

	echo "==============================="
	echo "            RECEIPT            "
	echo "==============================="
	echo "AMOUNT: " $amount
	echo "TO: " $2
	echo "FROM: " $ADDRESS
	echo "==============================="
	echo "HASH: " $hash
	echo "BLOCK: " $nanolooker
	echo "TIME: " $duration
	# echo "NOTE: Thanks for using Nano.to"

	exit 1

fi





# ██╗    ██╗ █████╗ ██╗     ██╗     ███████╗████████╗███████╗
# ██║    ██║██╔══██╗██║     ██║     ██╔════╝╚══██╔══╝██╔════╝
# ██║ █╗ ██║███████║██║     ██║     █████╗     ██║   ███████╗
# ██║███╗██║██╔══██║██║     ██║     ██╔══╝     ██║   ╚════██║
# ╚███╔███╔╝██║  ██║███████╗███████╗███████╗   ██║   ███████║
#  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝   ╚══════╝
                                                           
if [[ "$2" = "ls" ]] || [[ "$2" = "--wallets" ]] || [[ "$2" = "wallets" ]] || [[ "$2" = "accounts" ]] || [[ "$2" = "balances" ]] || [[ "$2" = "--wallets" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNTS=$(curl -s "https://nano.to/cli/wallets" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.accounts' <<< "$ACCOUNTS") == "[]" ]]; then
	echo "==============================="
	echo "         CLOUD WALLETS        "
	echo "==============================="
	echo "No additional wallets on file. "
	echo "==============================="
	echo "Use 'n2 shop' to add more. "
	echo "==============================="
	exit 1
	fi

	if [[ $(jq -r '.code' <<< "$ACCOUNTS") == "401" ]]; then
	rm $DIR/.n2-session
	echo
	echo "==============================="
	echo "    LOGGED OUT FOR SECURITY    "
	echo "==============================="
	echo "Use 'n2 login' to log back in. "
	echo "==============================="
	echo
	exit 1
	fi

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]]; then
		echo $ACCOUNT
		exit 1
	fi

	WALLETS=$(jq -r '.accounts' <<< "$ACCOUNTS")

	# echo
	echo "==============================="
	echo "         CLOUD WALLETS        "
	echo "==============================="
	jq -c '.[]' <<< $WALLETS | while read i; do
	# echo $i
	echo "ADDRESS: " $(jq -r '.address' <<< $i)
	echo "BALANCE: " $(jq -r '.balance' <<< $i) "(\$$(jq -r '.usd_value' <<< $i))"
	echo "PENDING: " $(jq -r '.pending' <<< $i) 
	echo "BLOCKS: " $(jq -r '.height' <<< $i)
	echo "==============================="
	done

	exit 1

fi


#  █████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███╗   ██╗████████╗
# ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║████╗  ██║╚══██╔══╝
# ███████║██║     ██║     ██║   ██║██║   ██║██╔██╗ ██║   ██║   
# ██╔══██║██║     ██║     ██║   ██║██║   ██║██║╚██╗██║   ██║   
# ██║  ██║╚██████╗╚██████╗╚██████╔╝╚██████╔╝██║ ╚████║   ██║   
# ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝                                                       

if [[ "$2" = "--account" ]] || [[ "$2" = "account" ]] || [[ "$2" = "wallet" ]] || [[ "$2" = "balance" ]] || [[ "$2" = "a" ]] || [[ "$2" = "--balance" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
	rm $DIR/.n2-session
	echo
	echo "==============================="
	echo "    LOGGED OUT FOR SECURITY    "
	echo "==============================="
	echo "Use 'n2 login' to log back in. "
	echo "==============================="
	echo
	exit 1
	fi

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]]; then
		echo $ACCOUNT
		exit 1
	fi

	username=$(jq -r '.username' <<< "$ACCOUNT")
	address=$(jq -r '.address' <<< "$ACCOUNT")
	api_key=$(jq -r '.api_key' <<< "$ACCOUNT")
	balance=$(jq -r '.balance' <<< "$ACCOUNT")
	pending=$(jq -r '.pending' <<< "$ACCOUNT")
	frontier=$(jq -r '.frontier' <<< "$ACCOUNT")
	two_factor=$(jq -r '.two_factor' <<< "$ACCOUNT")
	pow_usage=$(jq -r '.pow_usage' <<< "$ACCOUNT")
	pow_limit=$(jq -r '.pow_limit' <<< "$ACCOUNT")
	wallets=$(jq -r '.accounts' <<< "$ACCOUNT")

	# echo
	echo "==============================="
	echo "        NANO.TO ACCOUNT        "
	echo "==============================="
	echo "ACCOUNT: " $username
	echo "POW CREDITS: " "$pow_usage" "/" "$pow_limit"
	echo "TWO_FACTOR: " $two_factor
	echo "==============================="
	echo "         MASTER WALLET         "
	echo "==============================="
	echo "BALANCE: " $balance
	echo "PENDING: " $pending
	echo "ADDRESS: " $address
	echo "==============================="
	echo "Use 'n2 ls' to list wallets."
	echo "==============================="

	exit 1

fi




# ██████╗ ███████╗ ██████╗███████╗██╗██╗   ██╗███████╗
# ██╔══██╗██╔════╝██╔════╝██╔════╝██║██║   ██║██╔════╝
# ██████╔╝█████╗  ██║     █████╗  ██║██║   ██║█████╗  
# ██╔══██╗██╔══╝  ██║     ██╔══╝  ██║╚██╗ ██╔╝██╔══╝  
# ██║  ██║███████╗╚██████╗███████╗██║ ╚████╔╝ ███████╗
# ╚═╝  ╚═╝╚══════╝ ╚═════╝╚══════╝╚═╝  ╚═══╝  ╚══════╝                                               

if [[ "$2" = "deposit" ]] || [[ "$2" = "receive" ]] || [[ "$2" = "qr" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	address=$(jq -r '.address' <<< "$ACCOUNT")

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
		QR_JSON=$(curl -s "https://nano.to/$address?request=$2" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)
		echo $QR_JSON
		exit 1
	fi

	GET_QRCODE=$(curl -s "https://nano.to/cli/qrcode?address=$address&amount=$2" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)

	QRCODE=$(jq -r '.acii' <<< "$GET_QRCODE")

	# echo
	echo "==========================================="
	echo "         DEPOSIT NANO INTO NANO.TO         "
	echo "==========================================="
	echo $address
	# echo "NANOLOOKER: https://nanolooker.com/account/$address"
	echo "==========================================="
	cat <<EOF
$QRCODE
EOF

	exit 1

fi




# ███████╗███╗   ███╗ █████╗ ██╗██╗     
# ██╔════╝████╗ ████║██╔══██╗██║██║     
# █████╗  ██╔████╔██║███████║██║██║     
# ██╔══╝  ██║╚██╔╝██║██╔══██║██║██║     
# ███████╗██║ ╚═╝ ██║██║  ██║██║███████╗
# ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝                          

if [[ "$2" = "email" ]] || [[ "$2" = "-email" ]] || [[ "$2" = "--email" ]] || [[ "$2" = "-e" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	echo $(jq -r '.username' <<< "$ACCOUNT")

	exit 1

fi




#  █████╗ ██████╗ ██╗    ██╗  ██╗███████╗██╗   ██╗
# ██╔══██╗██╔══██╗██║    ██║ ██╔╝██╔════╝╚██╗ ██╔╝
# ███████║██████╔╝██║    █████╔╝ █████╗   ╚████╔╝ 
# ██╔══██║██╔═══╝ ██║    ██╔═██╗ ██╔══╝    ╚██╔╝  
# ██║  ██║██║     ██║    ██║  ██╗███████╗   ██║   
# ╚═╝  ╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚══════╝   ╚═╝                                       

if [[ "$2" = "api" ]] || [[ "$2" = "-api" ]] || [[ "$2" = "--api" ]] || [[ "$2" = "-k" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	echo $(jq -r '.api_key' <<< "$ACCOUNT")

	exit 1

fi


#  █████╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗███████╗
# ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝
# ███████║██║  ██║██║  ██║██████╔╝█████╗  ███████╗███████╗
# ██╔══██║██║  ██║██║  ██║██╔══██╗██╔══╝  ╚════██║╚════██║
# ██║  ██║██████╔╝██████╔╝██║  ██║███████╗███████║███████║
# ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝                                                        

if [[ "$2" = "address" ]] || [[ "$2" = "-address" ]] || [[ "$2" = "--address" ]] || [[ "$2" = "-a" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	echo $(jq -r '.address' <<< "$ACCOUNT")

	exit 1

fi


# ██╗      ██████╗  ██████╗  ██████╗ ██╗   ██╗████████╗
# ██║     ██╔═══██╗██╔════╝ ██╔═══██╗██║   ██║╚══██╔══╝
# ██║     ██║   ██║██║  ███╗██║   ██║██║   ██║   ██║   
# ██║     ██║   ██║██║   ██║██║   ██║██║   ██║   ██║   
# ███████╗╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝   ██║   
# ╚══════╝ ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   
                                                     

if [[ "$2" = "logout" ]]; then
	rm $DIR/.n2-session
	echo "Ok: You logged out of Nano.to."
	exit 1
fi


#  ██████╗ ██████╗ ██████╗ ███████╗
# ██╔════╝██╔═══██╗██╔══██╗██╔════╝
# ██║     ██║   ██║██║  ██║█████╗  
# ██║     ██║   ██║██║  ██║██╔══╝  
# ╚██████╗╚██████╔╝██████╔╝███████╗
#  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                                                                                
                                                      
if [[ "$2" = "--qrcode" ]] || [[ "$2" = "qrcode" ]] || [[ "$2" = "-qrcode" ]] || [[ "$2" = "-qr" ]] || [[ "$2" = "-q" ]] || [[ "$2" = "q" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	ADDRESS=$(jq -r '.address' <<< "$ACCOUNT")

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
		QR_JSON=$(curl -s "https://nano.to/$ADDRESS?request=$2" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)
		echo $QR_JSON
		exit 1
	fi

	USERNAME=$(jq -r '.username' <<< "$ACCOUNT")

	GET_QRCODE=$(curl -s "https://nano.to/cli/qrcode?address=$ADDRESS&amount=$2" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)

	QRCODE=$(jq -r '.acii' <<< "$GET_QRCODE")

	# echo
	echo "==========================================="
	echo "               RECEIVE NANO                "
	echo "==========================================="
	echo "ACCOUNT: " $USERNAME
	echo "ADDRESS: " $ADDRESS
	echo "==========================================="
	cat <<EOF
$QRCODE
EOF
	# echo

	exit 1

fi




# ██████╗ ███████╗ ██████╗██╗   ██╗ ██████╗██╗     ███████╗
# ██╔══██╗██╔════╝██╔════╝╚██╗ ██╔╝██╔════╝██║     ██╔════╝
# ██████╔╝█████╗  ██║      ╚████╔╝ ██║     ██║     █████╗  
# ██╔══██╗██╔══╝  ██║       ╚██╔╝  ██║     ██║     ██╔══╝  
# ██║  ██║███████╗╚██████╗   ██║   ╚██████╗███████╗███████╗
# ╚═╝  ╚═╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝╚══════╝╚══════╝                                                

if [[ $2 == "recycle" ]] || [[ $2 == "renew" ]]; then

	read -p 'Want to change your Nano address for a new one? All funds are moved over. This service is NOT free. It costs 0.01 NANO. (yes/no): ' YES

	if [[ $YES == "Yes" ]] || [[ $YES == "yes" ]]; then
		RECYCLE_ATTEMPT=$(curl -s "https://nano.to/cli/recycle" \
			-H "Accept: application/json" \
		  -H "session: $(cat $DIR/.n2-session)" \
			-H "Content-Type:application/json" \
			--request POST)
		echo "Success. Use 'n2 account' to see new address."
		exit 1
	fi

	echo "Canceled."

	exit 1

fi



#  ██████╗ ██████╗ ███╗   ██╗██╗   ██╗███████╗██████╗ ████████╗
# ██╔════╝██╔═══██╗████╗  ██║██║   ██║██╔════╝██╔══██╗╚══██╔══╝
# ██║     ██║   ██║██╔██╗ ██║██║   ██║█████╗  ██████╔╝   ██║   
# ██║     ██║   ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██╔══██╗   ██║   
# ╚██████╗╚██████╔╝██║ ╚████║ ╚████╔╝ ███████╗██║  ██║   ██║   
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝   
                                                             

if [ "$2" = "convert" ] || [ "$2" = "--convert" ] || [ "$2" = "-c" ] || [ "$2" = "c" ] || [ "$2" = "-c" ]; then
	TIMELINE='week'
	echo "================================="
	echo "       UNDER CONSTRUCTION        "
	echo "================================="
	echo "'n2 convert' is under development. Update N2 in a $TIMELINE or so. Tweet @nano2dev to remind me to get it done."
	echo "================================="
	echo "https://twitter.com/nano2dev"
	echo "================================="
	exit 1
fi



# ██████╗  ██████╗  ██████╗███████╗
# ██╔══██╗██╔═══██╗██╔════╝██╔════╝
# ██║  ██║██║   ██║██║     ███████╗
# ██║  ██║██║   ██║██║     ╚════██║
# ██████╔╝╚██████╔╝╚██████╗███████║
# ╚═════╝  ╚═════╝  ╚═════╝╚══════╝

if [ "$2" = "docs" ] || [ "$2" = "--docs" ] || [ "$2" = "-docs" ] || [ "$2" = "d" ] || [ "$2" = "-d" ]; then
	URL="https://docs.nano.to/n2"
	echo "Visit Docs: $URL"
	open $URL
	exit 1
fi


#  ██████╗██╗  ██╗ █████╗ ██╗███╗   ██╗
# ██╔════╝██║  ██║██╔══██╗██║████╗  ██║
# ██║     ███████║███████║██║██╔██╗ ██║
# ██║     ██╔══██║██╔══██║██║██║╚██╗██║
# ╚██████╗██║  ██║██║  ██║██║██║ ╚████║
#  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
                                    
if [ "$2" = "nanolooker" ] || [ "$2" = "--nl" ] || [ "$2" = "-nl" ] || [ "$2" = "-l" ]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
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

cat <<EOF
Usage:
  $ n2 cloud balance
  $ n2 cloud send @esteban 0.1
  $ n2 cloud qrcode
  $ n2 cloud receive
  $ n2 cloud renew
EOF

exit 1

fi


# ██████╗ ██████╗ ██╗ ██████╗███████╗
# ██╔══██╗██╔══██╗██║██╔════╝██╔════╝
# ██████╔╝██████╔╝██║██║     █████╗  
# ██╔═══╝ ██╔══██╗██║██║     ██╔══╝  
# ██║     ██║  ██║██║╚██████╗███████╗
# ╚═╝     ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝                                  

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then

	# AWARD FOR CLEANEST METHOD
	curl -s "https://nano.to/price?currency=$2" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET | jq
	exit 1

fi


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
	if [ "$2" = "--dev" ]; then
		curl -s -L "https://github.com/fwd/n2/raw/dev/n2.sh" -o /usr/local/bin/n2
		sudo chmod +x /usr/local/bin/n2
		echo "Installed latest 'development' version."
		exit 1
	fi
	if [ "$2" = "--prod" ]; then
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
	rm $DIR/.n2-session
	rm $DIR/.n2-rpc
	echo "CLI removed. Thanks for using N2. Hope to see soon."
	exit 1
fi


# ██╗  ██╗██╗   ██╗██╗  ██╗
# ██║  ██║██║   ██║██║  ██║
# ███████║██║   ██║███████║
# ██╔══██║██║   ██║██╔══██║
# ██║  ██║╚██████╔╝██║  ██║
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                         
echo "$DOCS"
