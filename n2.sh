#!/bin/bash

###############################
## n2 Command Line Tool      ##
## (c) 2018-2022 @nano2dev   ##
## Released for MIT License  ##
###############################

if ! command -v curl &> /dev/null
then sudo apt install curl -y
fi

if ! command -v jq &> /dev/null
then sudo apt install jq -y
fi

# GET HOME DIR
DIR=$(eval echo "~$different_user")
RPC="[::1]:7076"
# RPC="https://mynano.ninja/api"

VERSION=0.1
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
  $ n2 price
  $ n2 docs
  $ n2 login
  $ n2 register
  $ n2 account
  $ n2 logout

Blockchain
  $ n2 stats
  $ n2 ledger
  $ n2 reps
  $ n2 node

Wallet (Local Node)
  $ n2 wallet
  $ n2 wallet ls
  $ n2 wallet create 
  $ n2 wallet pow @username
  $ n2 wallet pending @username
  $ n2 wallet balance @username
  $ n2 wallet history @username
  $ n2 wallet send @username 10 
  $ n2 wallet change_rep @username
  $ n2 wallet receive HASH
  $ n2 wallet receive HASH
  $ n2 wallet remove ADDRESS
  $ n2 wallet recycle ADDRESS

Options
  --help, -h  Print Documentation.
  --update, -u  Get latest CLI Script.
  --version, -v  Print current CLI Version.
  --uninstall, -v  Remove CLI from system.
END_HEREDOC
)

#########
# PRICE #
#########

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then

	PRICE=$(curl -s "https://nano.to/price?currency=$2" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	_PRICE=$(jq -r '.price' <<< "$PRICE")
	SYMBOL=$(jq -r '.symbol' <<< "$PRICE")
	USERNAME=$(jq -r '.username' <<< "$PRICE")
	CURRENCY=$(jq -r '.currency' <<< "$PRICE")
	TIMESTAMP=$(jq -r '.timestamp' <<< "$PRICE")

	if [[ $3 == "--json" ]] || [[ $4 == "--json" ]]; then
		echo $(jq <<< "$ACCOUNT")
		exit 1
	else
		echo "==============================="
		echo "        NANO FIAT PRICE        "
		echo "==============================="
		echo "PRICE: " $_PRICE 
		echo "SYMBOL: " $SYMBOL 
		echo "CURRENCY: " $CURRENCY 
		echo "==============================="
	fi
	exit 1

fi

########
# DOCS #
########

if [ "$1" = "docs" ] || [ "$1" = "--docs" ] || [ "$1" = "-docs" ] || [ "$1" = "d" ] || [ "$1" = "-d" ]; then
	URL="https://docs.nano.to/n2"
	echo "Visit Docs: $URL"
	open $URL
	exit 1
fi

############
# CHECKOUT #
############

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

########
# HELP #
########

if [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-help" ] || [ "$1" = "-h" ]; then
	echo "$DOCS"
	exit 1
fi

###########
# VERSION #
###########

if [[ "$1" = "v" ]] || [[ "$1" = "-v" ]] || [[ "$1" = "--version" ]] || [[ "$1" = "version" ]]; then
	echo "Version: $VERSION"
	exit 1
fi

##########
# UPDATE #
##########

if [ "$1" = "u" ] || [ "$1" = "-u" ] || [ "$1" = "--update" ] || [ "$1" = "update" ]; then
	curl -s -L "https://github.com/fwd/n2/raw/master/n2.sh" -o /usr/local/bin/n2
	sudo chmod +x /usr/local/bin/n2
	echo "Installed latest version."
	exit 1
fi

###############
# 4. NODE RPC #
###############

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

if [[ "$1" = "node" ]]; then

	# if [[ $1 == "" ]]; then
	# 	# rpc "telemetry"
	# 	exit 1
	# fi

	# rpc $1
	curl -g -d '{ "action": "telemetry" }' "$RPC"
	
	exit 1
fi

#################
# 5 CLOUD LOGIN #
#################

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

#########################
# CLOUD 2FACTOR DISABLE #
#########################

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


#################
# CLOUD 2FACTOR #
#################

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
		echo "Error: You already have 2f enabled. Use 'n2 2f-remove' to change 2-factor."
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

##################
# CLOUD REGISTER #
##################

if [[ $1 == "register" ]]; then

	echo "$BANNER"

	echo 

	echo 'Welcome to the Cloud'

	echo 
	 
	read -p 'Email: ' username
	read -sp 'Password: ' password
	 
	echo 
	# echo "Thank you $username for showing interest in learning with www.tutorialkart.com"

	curl -s "https://nano.to/register" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "username": "$username", "password": "$password" }
EOF
	) 

	exit 1

fi


#################
# CLOUD ACCOUNT #
#################

if [[ "$1" = "account" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cli/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	USERNAME=$(jq -r '.username' <<< "$ACCOUNT")
	ADDRESS=$(jq -r '.address' <<< "$ACCOUNT")
	BALANCE=$(jq -r '.balance' <<< "$ACCOUNT")
	PENDING=$(jq -r '.pending' <<< "$ACCOUNT")
	API_KEY=$(jq -r '.api_key' <<< "$ACCOUNT")
	POW_USAGE=$(jq -r '.api_usage' <<< "$ACCOUNT")
	POW_LIMIT=$(jq -r '.api_limit' <<< "$ACCOUNT")
	TWO_FACTOR=$(jq -r '.two_factor' <<< "$ACCOUNT")
	CREATED=$(jq -r '.created_at' <<< "$ACCOUNT")

	if [[ $3 == "--json" ]] || [[ $4 == "--json" ]]; then
		echo $(jq <<< "$ACCOUNT")
		exit 1
	else
		echo "==============================="
		echo "        NANO.TO ACCOUNT        "
		echo "==============================="
		echo "USERNAME: " $USERNAME 
		echo "BALANCE: " $BALANCE 
		echo "PENDING: " $PENDING 
		if [[ $3 == "--show" ]] || [[ $4 == "--show" ]]; then
			# echo "API KEY: ********************" 
		  # echo $ADDRESS | egrep -o '[[:digit:]]{14}' | head -n1
		  echo "ADDRESS: " $ADDRESS
		else
		  echo "ADDRESS: ${ADDRESS:0:18}"
			# echo "API KEY: " $API_KEY 
		fi
		echo "2-FACTOR: " $TWO_FACTOR 
		echo "PoW USAGE: " $POW_USAGE 
		echo "PoW LIMIT: " $POW_LIMIT 
		if [[ $2 == "" ]]; then
			echo "API KEY: ********************" 
		else
			echo "API KEY: " $API_KEY 
		fi
		echo "JOINED: " $CREATED 
		echo "==============================="
	fi
	exit 1
fi

################
# CLOUD LOGOUT #
################

if [[ "$1" = "logout" ]]; then
	rm $DIR/.n2-session
	echo "Done: You logged out of Nano.to."
	exit 1
fi


################
# CLOUD LOGOUT #
################

if [[ "$1" = "--uninstall" ]]; then
	sudo rm /usr/local/bin/n2
	rm $DIR/.n2-session
	rm $DIR/.n2-rpc
	echo "CLI removed. Thank you for using n2. Come back soon!"
	exit 1
fi

###############
# 20. DEFAULT #
###############

echo "Command not found. Use 'n2 help' for list of commands."