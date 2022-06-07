#!/bin/bash

###############################
## n2 Command Line Tool      ##
## (c) 2018-2022 @nano2dev   ##
## Released for MIT License  ##
###############################

# Install 'jq' if needed.
if ! command -v jq &> /dev/null
then sudo apt install jq -y
fi

# Install 'curl' if needed. Really?
if ! command -v curl &> /dev/null
then sudo apt install curl -y
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

Wallet
  $ n2 balance
  $ n2 send @fosse 0.1
  $ n2 qrcode
  $ n2 receive
  $ n2 renew
  $ n2 store

Toolkit
  $ n2 price
  $ n2 convert
  $ n2 pow @esteban

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
                                                                                                                  
rpc() {
	SESSION=$(curl -s "$RPC" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "action": "$1" }
EOF
	))
	echo $SESSION
}

if [[ "$1" = "node" ]] || [[ "$1" = "local" ]]; then

	# LOCAL "NON-CUSTODIAL" WALLET, IS A WORK IN PROGRESS

	TIMELINE='year'
	echo 
	echo "'n2 node' is under development. Update N2 in a $TIMELINE or so. Tweet me @nano2dev to remind me to get it done."
	echo 

	# rpc $1
	# curl -g -d '{ "action": "telemetry" }' "$RPC"
	
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
                                                                           


if [[ $1 == "login" ]]; then

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
		echo "    2-FACTOR ENABLED    "
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

	echo "Logged in successfully."
	
	exit 1

fi




# ██████╗ ███████╗ ██████╗ ██╗███████╗████████╗███████╗██████╗ 
# ██╔══██╗██╔════╝██╔════╝ ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗
# ██████╔╝█████╗  ██║  ███╗██║███████╗   ██║   █████╗  ██████╔╝
# ██╔══██╗██╔══╝  ██║   ██║██║╚════██║   ██║   ██╔══╝  ██╔══██╗
# ██║  ██║███████╗╚██████╔╝██║███████║   ██║   ███████╗██║  ██║
# ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
                                                             
if [[ $1 == "register" ]]; then

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

	echo "Logged in successfully."
	
	exit 1

fi




# ██████╗       ███████╗ █████╗ 
# ╚════██╗      ██╔════╝██╔══██╗
#  █████╔╝█████╗█████╗  ███████║
# ██╔═══╝ ╚════╝██╔══╝  ██╔══██║
# ███████╗      ██║     ██║  ██║
# ╚══════╝      ╚═╝     ╚═╝  ╚═╝                      

if [[ "$1" = "2f-enable" ]] || [[ "$1" = "2f" ]] || [[ "$1" = "2factor" ]] || [[ "$1" = "2fa" ]] || [[ "$1" = "-2f" ]] || [[ "$1" = "--2f" ]] || [[ "$1" = "--2factor" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	HAS_TWO_FACTOR=$(curl -s "https://nano.to/cli/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
	--request GET | jq '.two_factor')

	if [[ $HAS_TWO_FACTOR == "true" ]]; then
		echo "You have 2f enabled. Use 'n2 2f-remove' to change 2-factor."
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

if [[ "$1" = "2f-disable" ]] || [[ "$1" = "2f-remove" ]]; then

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




#  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗ ██████╗ ██╗   ██╗████████╗
# ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝
# ██║     ███████║█████╗  ██║     █████╔╝ ██║   ██║██║   ██║   ██║   
# ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ██║   ██║██║   ██║   ██║   
# ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗╚██████╔╝╚██████╔╝   ██║   
#  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝                                                                 

if [ "$1" = "checkout" ] || [ "$1" = "--checkout" ] || [ "$1" = "-checkout" ] || [ "$1" = "c" ] || [ "$1" = "-c" ]; then

	if [[ $2 == "" ]]; then
		echo "Error: Username, or Address missing."
		exit 1
	fi

	if [[ $3 == "" ]]; then
		echo "Error: Amount missing."
		exit 1
	fi

	CHECKOUT=$(curl -s "https://nano.to/$2?cli=$3" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET | jq -r '.qrcode')

	# CHECKOUT=$( echo "cmd" | at "$when" 2>&1 )
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

if [[ $1 == "purchase" ]] || [[ $1 == "store" ]] || [[ $1 == "add" ]] || [[ $1 == "shop" ]] || [[ $1 == "--store" ]] || [[ $1 == "--shop" ]] || [[ $1 == "-s" ]]; then

	if [[ $2 == "pow" ]]; then
		if [[ $3 == "" ]]; then
			echo "Missing amount. Usage 'n2 add pow 10'"
			exit 1
		fi
curl -s "https://nano.to/cli/pow" \
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

cat <<EOF
███████╗██╗  ██╗ ██████╗ ██████╗ 
██╔════╝██║  ██║██╔═══██╗██╔══██╗
███████╗███████║██║   ██║██████╔╝
╚════██║██╔══██║██║   ██║██╔═══╝ 
███████║██║  ██║╚██████╔╝██║     
╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝                                                  
EOF

	echo "========================"
	echo "    AVAILABLE ITEMS     "
	echo "========================"
	echo "PoW ------------ Ӿ 0.01 "
	echo "========================"

	echo 
	
	echo "Usage: 'n2 add pow 10'"

	echo 

	exit 1

fi



# ██████╗  ██████╗ ██╗    ██╗
# ██╔══██╗██╔═══██╗██║    ██║
# ██████╔╝██║   ██║██║ █╗ ██║
# ██╔═══╝ ██║   ██║██║███╗██║
# ██║     ╚██████╔╝╚███╔███╔╝
# ╚═╝      ╚═════╝  ╚══╝╚══╝ 
                           
if [[ $1 == "pow" ]] || [[ $1 == "--pow" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)
	
  API_KEY=$(jq -r '.api_key' <<< "$ACCOUNT")
  # FRONTIER=$(jq -r '.frontier' <<< "$ACCOUNT")

	POW=$(curl -s "https://nano.to/$2/pow?key=$API_KEY" \
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

	echo $(jq -r '.work' <<< "$POW")

	exit 1

fi




# ███████╗███████╗███╗   ██╗██████╗ 
# ██╔════╝██╔════╝████╗  ██║██╔══██╗
# ███████╗█████╗  ██╔██╗ ██║██║  ██║
# ╚════██║██╔══╝  ██║╚██╗██║██║  ██║
# ███████║███████╗██║ ╚████║██████╔╝
# ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝                                   

if [[ $1 == "send" ]]; then

	USERNAME=$2
	AMOUNT=$3
	NOTE=$4

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

	SEND=$(curl -s "https://nano.to/cli/wallet" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "to": "$2", "amount": "$3", "note": "$4", "work": "$WORK" }
EOF
	))

	hash=$(jq -r '.hash' <<< "$SEND")
	amount=$(jq -r '.amount' <<< "$SEND")
	hash_url=$(jq -r '.hash_url' <<< "$SEND")
	nanolooker=$(jq -r '.nanolooker' <<< "$SEND")
	duration=$(jq -r '.duration' <<< "$SEND")

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
	echo "-------------------------------"
	echo "HASH: " $hash
	echo "URL: " $nanolooker
	echo "DURATION: " $duration
	# echo "NOTE: Thanks for using Nano.to"

	exit 1

fi




#  █████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███╗   ██╗████████╗
# ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║████╗  ██║╚══██╔══╝
# ███████║██║     ██║     ██║   ██║██║   ██║██╔██╗ ██║   ██║   
# ██╔══██║██║     ██║     ██║   ██║██║   ██║██║╚██╗██║   ██║   
# ██║  ██║╚██████╗╚██████╗╚██████╔╝╚██████╔╝██║ ╚████║   ██║   
# ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝                                                       

if [[ "$1" = "ls" ]] || [[ "$1" = "--account" ]] || [[ "$1" = "account" ]] || [[ "$1" = "wallet" ]] || [[ "$1" = "balance" ]] || [[ "$1" = "a" ]] || [[ "$1" = "w" ]] || [[ "$1" = "--wallet" ]] || [[ "$1" = "--balance" ]]; then

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

	username=$(jq -r '.username' <<< "$ACCOUNT")
	address=$(jq -r '.address' <<< "$ACCOUNT")
	api_key=$(jq -r '.api_key' <<< "$ACCOUNT")
	balance=$(jq -r '.balance' <<< "$ACCOUNT")
	pending=$(jq -r '.pending' <<< "$ACCOUNT")
	frontier=$(jq -r '.frontier' <<< "$ACCOUNT")
	two_factor=$(jq -r '.two_factor' <<< "$ACCOUNT")
	pow_usage=$(jq -r '.pow_usage' <<< "$ACCOUNT")
	pow_limit=$(jq -r '.pow_limit' <<< "$ACCOUNT")

	# echo
	echo "==============================="
	echo "        NANO.TO ACCOUNT        "
	echo "==============================="
	echo "BALANCE: " $balance
	echo "PENDING: " $pending
	echo "ADDRESS: " $address
	echo "--------------------------------"
	echo "ACCOUNT: " $username
	echo "POW CREDITS: " "$pow_usage" "/" "$pow_limit"
	# echo "API_KEY: " $api_key
	# echo "FRONTIER " $frontier
	echo "TWO_FACTOR: " $two_factor
	echo "==============================="
	# echo

	exit 1

fi




# ██████╗ ███████╗ ██████╗███████╗██╗██╗   ██╗███████╗
# ██╔══██╗██╔════╝██╔════╝██╔════╝██║██║   ██║██╔════╝
# ██████╔╝█████╗  ██║     █████╗  ██║██║   ██║█████╗  
# ██╔══██╗██╔══╝  ██║     ██╔══╝  ██║╚██╗ ██╔╝██╔══╝  
# ██║  ██║███████╗╚██████╗███████╗██║ ╚████╔╝ ███████╗
# ╚═╝  ╚═╝╚══════╝ ╚═════╝╚══════╝╚═╝  ╚═══╝  ╚══════╝                                               

if [[ "$1" = "deposit" ]] || [[ "$1" = "receive" ]] || [[ "$1" = "qr" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	# username=$(jq -r '.username' <<< "$ACCOUNT")
	address=$(jq -r '.address' <<< "$ACCOUNT")
	# api_key=$(jq -r '.api_key' <<< "$ACCOUNT")
	# balance=$(jq -r '.balance' <<< "$ACCOUNT")
	# pending=$(jq -r '.pending' <<< "$ACCOUNT")
	# frontier=$(jq -r '.frontier' <<< "$ACCOUNT")
	# two_factor=$(jq -r '.two_factor' <<< "$ACCOUNT")

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
	echo "-------------------------------------------"
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

if [[ "$1" = "email" ]] || [[ "$1" = "-email" ]] || [[ "$1" = "--email" ]] || [[ "$1" = "-e" ]]; then

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

if [[ "$1" = "api" ]] || [[ "$1" = "-api" ]] || [[ "$1" = "--api" ]] || [[ "$1" = "-k" ]]; then

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

if [[ "$1" = "address" ]] || [[ "$1" = "-address" ]] || [[ "$1" = "--address" ]] || [[ "$1" = "-a" ]]; then

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
                                                     

if [[ "$1" = "logout" ]]; then
	rm $DIR/.n2-session
	echo "Done: You logged out of Nano.to."
	exit 1
fi




#  ██████╗ ██████╗ ██████╗ ███████╗
# ██╔════╝██╔═══██╗██╔══██╗██╔════╝
# ██║     ██║   ██║██║  ██║█████╗  
# ██║     ██║   ██║██║  ██║██╔══╝  
# ╚██████╗╚██████╔╝██████╔╝███████╗
#  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                                                                                
                                                      
if [[ "$1" = "--qrcode" ]] || [[ "$1" = "qrcode" ]] || [[ "$1" = "-qrcode" ]] || [[ "$1" = "-qr" ]] || [[ "$1" = "-q" ]] || [[ "$1" = "q" ]]; then

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
	echo "-------------------------------------------"
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

if [[ $1 == "recycle" ]] || [[ $1 == "renew" ]]; then

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
                                                             

if [ "$1" = "convert" ] || [ "$1" = "--convert" ] || [ "$1" = "-c" ] || [ "$1" = "c" ] || [ "$1" = "-c" ]; then
	TIMELINE="week"
	echo 
	echo "'n2 convert' is not done yet. Update N2 in a $TIMELINE or so. Tweet me @nano2dev to remind me to get it done."
	echo 
	exit 1
fi



# ██████╗  ██████╗  ██████╗███████╗
# ██╔══██╗██╔═══██╗██╔════╝██╔════╝
# ██║  ██║██║   ██║██║     ███████╗
# ██║  ██║██║   ██║██║     ╚════██║
# ██████╔╝╚██████╔╝╚██████╗███████║
# ╚═════╝  ╚═════╝  ╚═════╝╚══════╝

if [ "$1" = "docs" ] || [ "$1" = "--docs" ] || [ "$1" = "-docs" ] || [ "$1" = "d" ] || [ "$1" = "-d" ]; then
	URL="https://docs.nano.to/n2"
	echo "Visit Docs: $URL"
	open $URL
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
                                                  

if [ "$1" = "u" ] || [ "$1" = "-u" ] || [ "$1" = "--update" ] || [ "$1" = "update" ]; then
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
