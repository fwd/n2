#!/bin/bash

#################################
## N2: Nano Command Line Tool  ##
## (c) 2018-3001 @nano2dev     ##
## Released under MIT License  ##
#################################

# Install 'jq' if needed.
if ! command -v jq &> /dev/null; then
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install jq -y
	else
		echo "${CYAN}Cloud${NC}: We could not auto install 'jq'. Please install it manually, before continuing."
		exit 1
	fi
fi

# Install 'curl' if needed.
if ! command -v curl &> /dev/null; then
	# Really?! What kind of rinky-dink machine is this?
	if [  -n "$(uname -a | grep Ubuntu)" ]; then
		sudo apt install curl -y
	else
		echo "${CYAN}Cloud${NC}: We could not auto install 'curl'. Please install it manually, before continuing."
		exit 1
	fi
fi

# VERSION: 0.4-C
# CODENAME: "GOOSE"
VERSION=0.5-D
GREEN=$'\e[0;32m'
BLUE=$'\e[0;34m'
CYAN=$'\e[1;36m'
RED=$'\e[0;31m'
NC=$'\e[0m'

GREEN2=$'\e[1;92m'

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

LOCAL_DOCS=$(cat <<EOF
Usage
⏺  $ n2 setup node
⏺  $ n2 balance --local
⏺  $ n2 whois @moon
⏺  $ n2 account @kraken --json
⏺  $ n2 send @esteban 0.1
⏺  $ n2 qrcode @fosse
⏺  $ n2 plugin --list
EOF
)

CLOUD_DOCS=$(cat <<EOF
Nano.to Cloud
✅ $ n2 login
✅ $ n2 register
✅ $ n2 account
✅ $ n2 username
✅ $ n2 2factor
✅ $ n2 logout
EOF
)

OPTIONS_DOCS=$(cat <<EOF
Options
--cloud, -c  Use Cloud Node (Custodial).
--local, -l  Use Local Node (Non-Custodial).
--help, -h  Print CLI Documentation.
--docs, -d  Open Nano.to Documentation.
--update, -u  Get latest CLI Script.
--version, -v  Print current CLI Version.
--uninstall, -u  Remove CLI from system.
EOF
)

DOCS=$(cat <<EOF
$LOCAL_DOCS

$CLOUD_DOCS

$OPTIONS_DOCS
EOF
)

if [[ $1 == "" ]] || [[ $1 == "help" ]] || [[ $1 == "list" ]] || [[ $1 == "--help" ]]; then
	cat <<EOF
$DOCS
EOF
	exit 1
fi

if [[ "$1" = "--json" ]]; then
	echo "Tip: Use the '--json' flag to get command responses in JSON."
	exit 1
fi

 
function sponsor() {
	echo "===========SPONSOR============"
	echo "  FREE 3-MONTH CLOUD SERVER   "
	echo "   (\$100 ON DIGITALOCEAN)    "
	echo "------------------------------"
	echo "https://m.do.co/c/f139acf4ddcb"
	echo "========ADVERTISE HERE========"
}






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
                                                      







# ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
# ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
# █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║
# ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║
# ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
# ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                         








# ██╗      █████╗ ███╗   ██╗██████╗ 
# ██║     ██╔══██╗████╗  ██║██╔══██╗
# ██║     ███████║██╔██╗ ██║██║  ██║
# ██║     ██╔══██║██║╚██╗██║██║  ██║
# ███████╗██║  ██║██║ ╚████║██████╔╝
# ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ 



function cloud_receive() {

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	re='^[0-9]+$'

	if [[ $1 =~ $re ]] || [[ $1 == "" ]] ; then
		ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)
		account=$(jq -r '.email' <<< "$ACCOUNT")
		address=$(jq -r '.address' <<< "$ACCOUNT")
	else
		ACCOUNT=$(curl -s "https://nano.to/$1/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)
		account=$1
		address=$(jq -r '.address' <<< "$ACCOUNT")
	fi

	if [[ $1 =~ $re ]] || [[ $1 == "" ]] ; then
		GET_QRCODE=$(curl -s "https://nano.to/cloud/qrcode?address=$address&amount=$1" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)
	else
		GET_QRCODE=$(curl -s "https://nano.to/cloud/qrcode?address=$address&amount=$2" \
			-H "Accept: application/json" \
			-H "session: $(cat $DIR/.n2-session)" \
			-H "Content-Type:application/json" \
			--request GET)
	fi

	QRCODE=$(jq -r '.acii' <<< "$GET_QRCODE")

	# echo
	if [[ $1 =~ $re ]] || [[ $1 == "" ]] ; then
	echo "======================="
	echo "      DEPOSIT NANO     "
	echo "======================="
	else
	echo "======================="
	echo "        SEND NANO      "
	echo "======================="
	fi

	if [[ $1 =~ $re ]] || [[ $2 =~ $re ]] ; then
		echo "AMOUNT: $1 NANO"
		#statements
	fi
	echo "ADDRESS: $address"
	# if [[ "$4" != "--no-account" ]] && [[ "$5" != "--no-account" ]]; then
	# echo "USERNAME: $account"
	# fi
	echo "======================="
	if [[ "$2" != "--no-qr" ]] && [[ "$3" != "--no-qr" ]]; then
		cat <<EOF
$QRCODE
EOF
	fi

	exit 1
}

function cloud_balance() {

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	# echo "as" $ACCOUNT

	# exit 1

	if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
		rm $DIR/.n2-session
		# echo
		echo "==============================="
		echo "    LOGGED OUT FOR SECURITY    "
		echo "==============================="
		echo "Use 'n2 login' to log back in. "
		echo "==============================="
		echo
		exit 1
	fi

	if [[ $(jq -r '.error' <<< "$ACCOUNT") == "433" ]]; then

	RMESSAGE=$(jq -r '.message' <<< "$ACCOUNT")

WELCOME=$(cat <<EOF

===============================
      VERIFY EMAIL ADDRESS      
===============================
$RMESSAGE
===============================
Enter Code: 
EOF
)


	read -p "$WELCOME" EMAIL_OTP

	# echo $EMAIL_OTP

	# exit 1

	VERIFY_ATTEMPT=$(curl -s "https://nano.to/cloud/verify?code=$EMAIL_OTP" \
		-H "Accept: application/json" \
	  -H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request POST)

	echo $VERIFY_ATTEMPT

	exit 1
fi

	# echo $ACCOUNT

	# 	# echo 
	# 	# echo 
	# 	# echo "========================"
	# 	# echo "   2-FACTOR REQUIRED    "
	# 	# echo "========================"
	# 	# echo

	# 	# read -sp 'Enter OTP Code: ' OTP_CODE

	# exit 1

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]]; then
		echo $ACCOUNT
		exit 1
	fi

	email=$(jq -r '.email' <<< "$ACCOUNT")
	username=$(jq -r '.username' <<< "$ACCOUNT")
	usernames=$(jq -r '.usernames' <<< "$ACCOUNT")
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
	echo "         ${CYAN}CLOUD ACCOUNT${NC}       "
	echo "==============================="
	# echo "WALLETS: " $wallets
	# echo "==============================="
	echo "BALANCE: "$balance
	echo "PENDING: "$pending
	echo "ADDRESS: "$address
	echo "BROWSER: https://nanolooker.com/account/"$address
	echo "==============================="
	echo "DOMAINS: "$usernames
	echo "ACCOUNT: "$email
	if [[ $two_factor == "TRUE" ]]; then
		#statements
		echo "2F_AUTH: ${GREEN}"$two_factor "${NC}"
	else
		echo "2F_AUTH: ${RED}"$two_factor "${NC}"
	fi
	echo "==============================="

	exit 1

}


function cloud_login() {

		if [[ $(cat $DIR/.n2-session 2>/dev/null) != "" ]]; then
			echo "${CYAN}Cloud${NC}: You're already logged in. Use 'n2 logout' to logout."
			exit 1
		fi



		echo "Welcome back"

		echo

		USERNAME=$3
		PASSWORD=$4

WELCOME=$(cat <<EOF

========================
      NANO.TO LOGIN      
========================

Welcome Back

Email:
EOF
)

		if [[ $USERNAME == "" ]]; then
			read -p "$WELCOME " USERNAME
		fi

		if [[ $PASSWORD == "" ]]; then
			echo
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

			# echo 
			# echo 
			# echo "========================"
			# echo "   2-FACTOR REQUIRED    "
			# echo "========================"
			# echo

OTP_REQUIRED=$(cat <<EOF


OTP Code:
EOF
)

			echo 

			read -sp "$OTP_REQUIRED " OTP_CODE

			echo
			# read -sp 'Enter OTP Code: ' OTP_CODE

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
			echo "${CYAN}Cloud${NC}:" $(jq -r '.message' <<< "$LOGIN_ATTEMPT")
			exit 1
		fi

		rm $DIR/.n2-session 2>/dev/null

		echo $(jq -r '.session' <<< "$LOGIN_ATTEMPT") >> $DIR/.n2-session

		# echo

		echo "${GREEN}Cloud${NC}: Logged in. "
		
		exit 1
}

function cloud_register() {

		if [[ $(cat $DIR/.n2-session 2>/dev/null) != "" ]]; then
			echo "${CYAN}Cloud${NC}: You're already logged in. Use 'n2 logout' to logout."
			exit 1
		fi

		# echo
		# echo "========================"
		# echo "    NANO.TO REGISTER    "
		# echo "========================"
		# echo

		# echo 'Create New Account'

		# echo 

RWELCOME=$(cat <<EOF

========================
☁️      REGISTER       ☁️ 
========================

Welcome to the Cloud

Email:
EOF
)
		 
		if [[ $USERNAME == "" ]]; then
			read -p "$RWELCOME " USERNAME
		fi

		if [[ $PASSWORD == "" ]]; then
			echo
			read -sp 'Password: ' PASSWORD
		fi
		 
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
			echo "${CYAN}Cloud${NC}:" $(jq -r '.message' <<< "$REGISTER_ATTEMPT")
			exit 1
		fi

		rm $DIR/.n2-session 2>/dev/null

		echo $(jq -r '.session' <<< "$REGISTER_ATTEMPT") >> $DIR/.n2-session

		# echo
		# sleep 0.1

		ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)

		if [[ $(jq -r '.error' <<< "$ACCOUNT") != "433" ]]; then
			echo "${CYAN}Cloud${NC}: $(jq -r '.message' <<< "$ACCOUNT")"
			exit 1
		fi

		if [[ $(jq -r '.error' <<< "$ACCOUNT") == "433" ]]; then

			RMESSAGE=$(jq -r '.message' <<< "$ACCOUNT")

			WELCOME=$(cat <<EOF

===============================
      VERIFY EMAIL ADDRESS      
===============================
$RMESSAGE
===============================
Enter Code: 
EOF
			)


			read -p "$WELCOME" EMAIL_OTP

			# echo $EMAIL_OTP

			# exit 1

			VERIFY_ATTEMPT=$(curl -s "https://nano.to/cloud/verify?code=$EMAIL_OTP" \
			-H "Accept: application/json" \
			-H "session: $(cat $DIR/.n2-session)" \
			-H "Content-Type:application/json" \
			--request POST)

			echo $VERIFY_ATTEMPT

			exit 1

		fi
	
	exit 1

}

function setup_2fa() {
	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: Not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	HAS_TWO_FACTOR=$(curl -s "https://nano.to/cloud/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
	--request GET | jq '.two_factor')

	if [[ $HAS_TWO_FACTOR == "true" ]]; then
		echo "2-factor already enabled. Use 'n2 2f-remove' to change 2-factor."
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
		echo "${CYAN}Cloud${NC}: No code. Try again, but from scratch."
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
}

function remove_2fa() {
	HAS_TWO_FACTOR=$(curl -s "https://nano.to/cloud/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
	--request GET | jq '.two_factor')

	if [[ $HAS_TWO_FACTOR == "false" ]]; then
		echo "${CYAN}Cloud${NC}: You don't have 2f enabled. Use 'n2 2f' to enable it."
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
		echo "${CYAN}Cloud${NC}: No code. Try again, but from scratch."
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
}

function local_send() {

	if curl -s --fail -X POST '[::1]:7076'; then
		echo ""
	else
	   echo "${CYAN}Cloud${NC}: No local Node found. Use 'n2 setup node' or use 'n2 cloud send'"
	   exit 1
	fi;

	if [[ $2 == "" ]]; then
		echo "${CYAN}Cloud${NC}: Missing Username or Nano Address."
		exit 1
	fi
	
	if [[ $3 == "" ]]; then
		echo "${CYAN}Cloud${NC}: Missing amount. Use 'all' to send balance."
		exit 1
	fi

	WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}' | tr -d '[:space:]' )

	UUID=$(cat /proc/sys/kernel/random/uuid)

	AMOUNT_IN_RAW=$(curl -s "https://nano.to/cloud/convert/toRaw/$3" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)

	SRC=""
	DEST=""

	ACCOUNT=$(curl -s "https://nano.to/$SRC/account" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	POW=$(curl -s "https://nano.to/$(jq -r '.frontier' <<< "$ACCOUNT")/pow" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	# echo $POW

	# exit 1

	if [[ $(jq -r '.error' <<< "$POW") == "429" ]]; then
		echo
		echo "==============================="
		echo "       USED ALL CREDITS        "
		echo "==============================="
		echo "  Use 'n2 buy pow' or wait.    "
		echo "==============================="
		echo
		return
	fi

	WORK=$(jq -r '.work' <<< "$POW")

	SEND_ATTEMPT=$(curl -s '[::1]:7076' \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{
	"action": "send",
	"wallet": "$WALLET_ID",
	"source": "$SRC",
	"destination": "$DEST",
	"amount": "$(jq -r '.value' <<< "$AMOUNT_IN_RAW")",
	"id": "$UUID",
	"json_block": "true",
	"work": "$WORK"
}
EOF
	))

	if [[ $(jq -r '.block' <<< "$SEND_ATTEMPT") == "" ]]; then
		echo
		echo "================================"
		echo "             ERROR              "
		echo "================================"
		echo "$(jq -r '.error' <<< "$SEND_ATTEMPT") "
		echo "================================"
		echo
		exit 1
	fi

	echo "==============================="
	echo "         NANO RECEIPT          "
	echo "==============================="
	echo "AMOUNT: "$3
	echo "TO: "$DEST
	echo "FROM: "$SRC
	echo "BLOCK: "$(jq -r '.block' <<< "$SEND_ATTEMPT")
	echo "--------------------------------"
	echo "BROWSER: https://nanolooker.com/block/$(jq -r '.block' <<< "$SEND_ATTEMPT")"
	echo "==============================="

	exit 1
}

function cloud_send() {

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: Not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	if [[ $1 == "" ]]; then
		echo "${CYAN}Cloud${NC}: Missing @Username or Nano Address."
		return
		# read -p 'To (@Username or Address): ' USERNAME
	fi
	
	if [[ $2 == "" ]]; then
		echo "${CYAN}Cloud${NC}: Missing Amount. Use 'all' to empty."
		return
		# read -p 'Amount: ' AMOUNT
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)
		
  # ADDRESS=$(jq -r '.address' <<< "$ACCOUNT")
  FRONTIER=$(jq -r '.frontier' <<< "$ACCOUNT")

	POW=$(curl -s "https://nano.to/$FRONTIER/pow" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	# if [[ $(jq -r '.work' <<< "$POW") == "" ]]; then
	# 	echo "${RED}POW${NC}: $(jq -r '.message' <<< "$POW")"
	# 	exit 1
	# fi

	if [[ $(jq -r '.error' <<< "$POW") == "429" ]]; then
		echo
		echo "==============================="
		echo "       USED ALL CREDITS        "
		echo "==============================="
		echo "  Use 'n2 add pow' or wait.    "
		echo "==============================="
		echo
		return
	fi

	# echo $POW
	# exit 1
	WORK=$(jq -r '.work' <<< "$POW")

	SEND=$(curl -s "https://nano.to/cloud/send" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "to": "$1", "amount": "$2", "work": "$WORK" }
EOF
	))

	# echo $SEND

	if [[ $(jq -r '.error' <<< "$SEND") == "401" ]]; then
		echo "======================="
		echo "${CYAN}Cloud${NC}: $(jq -r '.message' <<< "$SEND")"
		exit 1
	fi

	if [[ $(jq -r '.error' <<< "$SEND") == "444" ]]; then
		if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
			echo $SEND
			exit 1
		fi
		echo "==============================="
		echo "       INSUFFICIENT FUNDS      "
		echo "==============================="
		echo "PENDING: $(jq -r '.pending' <<< "$ACCOUNT") "
		echo "BALANCE: $(jq -r '.balance' <<< "$ACCOUNT") "
		echo "-------------------------------"
		echo "Use 'n2 cloud receive'"
		echo "==============================="
		# echo "NANOLOOKER: https://nanolooker.com/account/"$(jq -r '.address' <<< $ACCOUNT)
		echo
		exit 1
	fi

	if [[ $(jq -r '.code' <<< "$SEND") == "401" ]]; then
		rm $DIR/.n2-session
		# echo
		echo "==============================="
		echo "    LOGGED OUT FOR SECURITY    "
		echo "==============================="
		echo "Use 'n2 login' to log back in. "
		echo "==============================="
		echo
		exit 1
	fi

	if [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]]; then
		echo $SEND
		return
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
		return
	fi

	hash=$(jq -r '.hash' <<< "$SEND")
	# hash=$(jq -r '.from' <<< "$SEND")
	address=$(jq -r '.address' <<< "$ACCOUNT")
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
		return
		# exit 1
	fi

	echo "==============================="
	echo "          ${GREEN}SENT NANO${NC}       "
	# echo "        ${GREEN}SENT SUCCESSFUL${NC}       "
	echo "==============================="
	echo "TO: " $1
	echo "FROM: " $address
	echo "AMOUNT: " $amount
	echo "==============================="
	echo "HASH: " $hash
	echo "BLOCK: " $nanolooker
	echo "==============================="
	# echo "DURATION: " $duration
	# echo "FEE: 0.000"

	return

}

function hit_by_bus() {


	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: Not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

OTP_REQUIRED_FIRST=$(cat <<EOF

===============================
       2-FACTOR REQUIRED       
===============================
Enter Code: 
EOF
)

	read -p "$OTP_REQUIRED_FIRST" OTP_CODE

	# read -sp 'Enter OTP Code: ' OTP_CODE

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	HAS_TWO_FACTOR=$(jq -r '.two_factor' <<< "$ACCOUNT")

	if [[ $HAS_TWO_FACTOR == "false" ]]; then
		rm $DIR/.n2-session
		echo
		echo "==============================="
		echo "       2-FACTOR REQUIRED       "
		echo "==============================="
		echo "Use 'n2 2f' to setup 2-FA OTP. "
		echo "==============================="
		echo
	fi


	if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
		rm $DIR/.n2-session
		# echo
		echo "==============================="
		echo "    LOGGED OUT FOR SECURITY    "
		echo "==============================="
		echo "Use 'n2 login' to log back in. "
		echo "==============================="
		echo
		exit 1
	fi


	ADDRESS=$(jq -r '.address' <<< "$ACCOUNT")

	KEY=$(curl -s "https://nano.to/cloud/$ADDRESS/seed?code=$OTP_CODE" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	echo $KEY

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

}















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
                                                                     
             



                                                                     
                                                                     
                                                                     
                                                                     
                                                                     
                                                                     
#  ██████╗ ██████╗ ███████╗███████╗███████╗███████╗                    
# ██╔════╝██╔═══██╗██╔════╝██╔════╝██╔════╝██╔════╝                    
# ██║     ██║   ██║█████╗  █████╗  █████╗  █████╗                      
# ██║     ██║   ██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══╝                      
# ╚██████╗╚██████╔╝██║     ██║     ███████╗███████╗                    
#  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚══════╝                    
                                                                     
                                                                     
                                                                     
                                                                     
                                                                     
                      



                                                                     
                                                                     
# ██╗      █████╗ ███╗   ██╗██████╗                                    
# ██║     ██╔══██╗████╗  ██║██╔══██╗                                   
# ██║     ███████║██╔██╗ ██║██║  ██║                                   
# ██║     ██╔══██║██║╚██╗██║██║  ██║                                   
# ███████╗██║  ██║██║ ╚████║██████╔╝                                   
# ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝                                    
                                                                                                     
                                                                     
















if [[ "$1" = "rpc" ]] || [[ "$1" = "--rpc" ]] || [[ "$1" = "curl" ]] || [[ "$1" = "--curl" ]] ; then

	curl -s "[::1]:7076" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "action": "$2", "json_block": "true" }
EOF
) | jq

	exit 1
fi

if [[ "$1" = "node" ]] || [[ "$1" = "--exec" ]]; then
	docker exec -it nano-node /usr/bin/nano_node $1 $2 $3 $4
	exit 1
fi

if [[ "$1" = "--wallet" ]]; then
	docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}'
fi

# if [[ "$1" = "--seed" ]] || [[ "$1" = "--secret" ]]; then
# 	WALLET_ID=$(docker exec -it nano-node /usr/bin/nano_node --wallet_list | grep 'Wallet ID' | awk '{ print $NF}')
# 	SEED=$(docker exec -it nano-node /usr/bin/nano_node --wallet_decrypt_unsafe --wallet=$WALLET_ID | grep 'Seed' | awk '{ print $NF}' | tr -d '\r')
# 	echo $SEED
# fi

if [[ "$1" = "favorites" ]] || [[ "$1" = "saved" ]]; then

	if [[ $(cat $DIR/.n2-favorites 2>/dev/null) == "" ]]; then
		echo "[{ \"hello\": \"world\"  }]" >> $DIR/.n2-favorites
	fi

	cat $DIR/.n2-favorites

	exit 1

fi

if [[ "$1" = "reset-saved" ]]; then
	rm $DIR/.n2-favorites
	echo "[]" >> $DIR/.n2-favorites
	exit 1
fi

if [[ "$1" = "save" ]] || [[ "$1" = "favorite" ]]; then

	if [[ $(cat $DIR/.n2-favorites 2>/dev/null) == "" ]]; then
		echo "[]" >> $DIR/.n2-favorites
	fi

	if [[ "$2" = "" ]]; then
		echo "${CYAN}Cloud${NC}: Missing Nano Address."
		exit 1
	fi

	if [[ "$3" = "" ]]; then
		echo "${CYAN}Cloud${NC}: Missing Nickname."
		exit 1
	fi

	SAVED="$(cat $DIR/.n2-favorites)" 
	rm $DIR/.n2-favorites 
	jq <<< "$SAVED" | jq ". + [ { \"name\": \"$1\", \"address\": \"$2\" } ]" >> $DIR/.n2-favorites 

	exit

fi



if [[ $1 == "send" ]] || [[ $1 == "--send" ]] || [[ $1 == "-s" ]]; then
	
# 	if [[ "$4" != "--cloud" ]] && [[ "$4" != "--local" ]]; then
# cat <<EOF
# Usage:
#   $ n2 send @esteban 10 --local
#   $ n2 send @esteban 10 --cloud
# EOF
# 		exit 1
# 	fi

	if [[ $4 == '--local' ]]; then

		cat <<EOF
$(local_send $2 $3 $4)
EOF
		exit 1
	else
		cat <<EOF
$(cloud_send $2 $3 $4)
EOF
	fi;

	# if [[ "$4" != "--cloud" ]] && [[ "$4" != "--local" ]]; then
	# 	echo "==============================="
	# 	echo "TIP: Use 'n2 $1 --cloud' or 'n2 $1 --local' to set wallet." 
	# 	echo "==============================="
	# fi

	exit 1

fi


if [[ $1 == "balance" ]] || [[ $1 == "accounts" ]] || [[ $1 == "account" ]] || [[ $1 == "ls" ]]; then

	if curl -s --fail -X POST '[::1]:7076' || [[ $2 == '--local' ]]; then
		echo 
		# $(cloud_balance $1 $2 $3 $4 $5)
cat <<EOF
${GREEN}Local${NC}: Non-custodial local Wallet is in-development. 

Github: https://github.com/fwd/n2
Twitter: https://twitter.com/nano2dev

EOF
		exit 1
	else
		cat <<EOF
$(cloud_balance $1 $2 $3 $4 $5)
EOF
	fi;

	# if [[ "$2" != "--cloud" ]] && [[ "$2" != "--local" ]]; then
	# 	echo "TIP: Use 'n2 $1 --cloud' or 'n2 $1 --local' to set wallet." 
	# 	echo "==============================="
	# fi

	exit 1

fi




if [[ "$1" = "setup" ]] || [[ "$1" = "--setup" ]] || [[ "$1" = "install" ]] || [[ "$1" = "run" ]]; then

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
			echo ""
		elif [[ "$OSTYPE" == "darwin"* ]]; then
			echo "${CYAN}Cloud${NC}: You're on a Mac. OS not supported. Try a Cloud server running Ubuntu."
			sponsor
			exit 1
		  # Mac OSX
		elif [[ "$OSTYPE" == "cygwin" ]]; then
			echo "${CYAN}Cloud${NC}: Operating system not supported."
			sponsor
			exit 1
		  # POSIX compatibility layer and Linux environment emulation for Windows
		elif [[ "$OSTYPE" == "msys" ]]; then
			echo "${CYAN}Cloud${NC}: Operating system not supported."
			sponsor
			exit 1
		  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
		elif [[ "$OSTYPE" == "win32" ]]; then
		  # I'm not sure this can happen.
			echo "${CYAN}Cloud${NC}: Operating system not supported."
			sponsor
			exit 1
		elif [[ "$OSTYPE" == "freebsd"* ]]; then
		  # ...
			echo "${CYAN}Cloud${NC}: Operating system not supported."
			sponsor
			exit 1
		else
		   # Unknown.
			echo "${CYAN}Cloud${NC}: Operating system not supported."
			sponsor
			exit 1
		fi

		# Coming soon
		if [[ "$2" = "pow" ]] || [[ "$2" = "--pow" ]] || [[ "$2" = "--pow-server" ]]; then
			read -p 'Setup a Live Nano Node: Enter 'y' to continue: ' YES
			if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
				echo "Coming soon"
				# @reboot ~/nano-work-server/target/release/nano-work-server --gpu 0:0
				# $DIR/nano-work-server/target/release/nano-work-server --cpu 2
				# $DIR/nano-work-server/target/release/nano-work-server --gpu 0:0
				exit 1
			fi
			echo "Canceled"
			exit 1
		fi

		# Sorta working
		if [[ "$2" = "node" ]] || [[ "$2" = "--node" ]]; then
			read -p 'Setup a Live Nano Node: Enter 'y' to continue: ' YES
			if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
				cd $DIR && git clone https://github.com/fwd/nano-docker.git
				LATEST=$(curl -sL https://api.github.com/repos/nanocurrency/nano-node/releases/latest | jq -r ".tag_name")
				cd $DIR/nano-docker && sudo ./setup.sh -s -t $LATEST
				exit 1
			fi
			echo "Canceled"
			exit 1
		fi

		# Sorta working
		if [[ "$2" = "gpu" ]] || [[ "$2" = "--gpu" ]]; then
			read -p 'Setup NVIDIA GPU. Enter 'y' to continue: ' YES
			if [[ "$YES" = "y" ]] || [[ "$YES" = "Y" ]]; then
				sudo apt-get purge nvidia*
				sudo ubuntu-drivers autoinstall
				exit 1
			fi
			echo "Canceled"
			exit 1
		fi

cat <<EOF
Usage:
  $ n2 setup node
  $ n2 setup gpu
EOF
		exit 1

fi



if [[ $1 == "login" ]] || [[ $2 == "login" ]]; then
cat <<EOF
$(cloud_login $1 $2 $3 $4 $5)
EOF
	exit 1
fi

if [[ $1 == "register" ]] || [[ $2 == "register" ]]; then
cat <<EOF
$(cloud_register $1 $2 $3 $4 $5)
EOF
	exit 1
fi


if [[ $1 == "cloud" ]] || [[ $1 == "c" ]]; then

	if [[ "$2" = "ls" ]] || [[ "$2" = "--account" ]] || [[ "$2" = "account" ]] || [[ "$2" = "wallet" ]] || [[ "$2" = "balance" ]] || [[ "$2" = "a" ]] || [[ "$2" = "--balance" ]]; then
cat <<EOF
$(cloud_balance $1 $2 $3 $4 $5)
EOF
	exit 1
fi


# if [[ $2 == "send" ]]; then
# cat <<EOF
# $(cloud_send $1 $2 $3 $4 $5)
# EOF
# 	exit 1
# fi

if [[ "$2" = "2f-disable" ]] || [[ "$2" = "2f-remove" ]]; then
cat <<EOF
$(remove_2fa $1 $2 $3 $4 $5)
EOF
	exit 1
fi

if [[ "$2" = "2f-enable" ]] || [[ "$2" = "2f" ]] || [[ "$2" = "2factor" ]] || [[ "$2" = "2fa" ]] || [[ "$2" = "-2f" ]] || [[ "$2" = "--2f" ]] || [[ "$2" = "--2factor" ]]; then
cat <<EOF
$(setup_2fa $1 $2 $3 $4 $5)
EOF
	exit 1
fi

fi

# if [ "$1" = "secret" ] || [ "$1" = "--seed" ]; then
# cat <<EOF
# $(hit_by_bus $1 $2 $3 $4 $5)
# EOF
# 	exit 1
# fi

if [[ "$1" = "deposit" ]] || [[ "$1" = "receive" ]] || [[ "$1" = "qr" ]] || [[ "$1" = "--qrcode" ]] || [[ "$1" = "qrcode" ]] || [[ "$1" = "-qrcode" ]] || [[ "$1" = "-qr" ]] || [[ "$1" = "-q" ]] || [[ "$1" = "q" ]]; then

	if [[ $2 == '--cloud' ]] ||  [[ $2 == '--local' ]] || [[ $2 == '--json' ]]; then
cat <<EOF
Usage:
  $ n2 $1 0.44 --local
  $ n2 $1 100 --cloud
EOF
		exit 1
	fi

	if curl -s --fail -X POST '[::1]:7076' || [[ $3 == '--local' ]]; then
			echo 
			# $(cloud_receive $1 $2 $3 $4 $5)
	cat <<EOF
${GREEN}Local${NC}: Non-custodial local Wallet is in-development. 

Github: https://github.com/fwd/n2
Twitter: https://twitter.com/nano2dev

EOF
		exit 1

	else



cat <<EOF
$(cloud_receive $2 $3 $4 $5 $6)
EOF
	fi;


	# if [[ "$3" != "--cloud" ]] && [[ "$3" != "--local" ]]; then
	# 	echo "======================="
	# 	echo "TIP: Use 'n2 $1 $2 --cloud' or 'n2 $1 $2 --local' to set wallet." 
	# 	echo "======================="
	# fi

	exit 1 
fi

# fi
                

# ██╗    ██╗██╗  ██╗ ██████╗ ██╗███████╗
# ██║    ██║██║  ██║██╔═══██╗██║██╔════╝
# ██║ █╗ ██║███████║██║   ██║██║███████╗
# ██║███╗██║██╔══██║██║   ██║██║╚════██║
# ╚███╔███╔╝██║  ██║╚██████╔╝██║███████║
#  ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚══════╝                                                                  

if [ "$1" = "username" ] || [ "$1" = "lookup" ] || [ "$1" = "find" ] || [ "$1" = "whois" ] || [ "$1" = "search" ] || [ "$1" = "name" ] || [ "$1" = "-w" ] || [ "$1" = "-f" ]; then

	if [[ $2 == "" ]]; then
cat <<EOF
Usage:
  $ n2 $1 @fosse
  $ n2 $1 @moon --json
EOF
		exit 1
	fi

	if [[ "$3" == "--claim" ]] || [[ "$3" == "claim" ]] || [[ "$3" == "--verify" ]]  || [[ "$3" == "verify" ]]; then
		if [[ "$4" == "--check" ]]; then
			CHECK_CLAIM=$(curl -s "https://nano.to/cloud/verify?username=$2" \
			-H "Accept: application/json" \
			-H "session: $(cat $DIR/.n2-session)" \
			-H "Content-Type:application/json" \
			--request POST)
			echo $CHECK_CLAIM
			exit 1
		fi
	CLAIM_WHOIS=$(curl -s "https://nano.to/$2/account" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)
	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	AMOUNT_RAW_CONSP=$(curl -s "https://nano.to/cloud/convert/toRaw/1.133" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

		echo "==============================="
		echo "   VERIFY USERNAME OWNERSHIP   "
		echo "==============================="
		echo "Allows Username control via N2."
		echo "Username Address is NOT changed."
		echo "==============================="
		echo "SEND: Ӿ 1.133"
		echo "FROM: "$(jq -r '.address' <<< $CLAIM_WHOIS)
		echo "TO: "$(jq -r '.address' <<< $ACCOUNT)
		echo "==============================="
		echo "QRCODE: https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=nano:$(jq -r '.address' <<< $ACCOUNT)?amount=$(jq -r '.value' <<< "$AMOUNT_RAW_CONSP")"
		echo "DLINK: nano:$(jq -r '.address' <<< $ACCOUNT)?amount=$(jq -r '.value' <<< "$AMOUNT_RAW_CONSP")"
		echo "==============================="
		echo "AFTER: n2 $1 $2 $3 --check"
		echo "==============================="
		exit 1
	fi

	if [[ "$3" == "--data" ]] || [[ "$3" == "--lease" ]] || [[ "$3" == "lease" ]]  || [[ "$3" == "expires" ]] || [[ "$3" == "--exp" ]] ; then
		LEASE_INFO=$(curl -s "https://nano.to/$2/username" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)
		# echo $LEASE_INFO
		echo "==============================="
		echo "      USERNAME LEASE DATA      "
		echo "==============================="
		echo "USERNAME: @"$(jq -r '.namespace' <<< $LEASE_INFO)
		echo "ADDRESS: @"$(jq -r '.address' <<< $LEASE_INFO)
		echo "CREATED: @"$(jq -r '.created' <<< $LEASE_INFO)
		echo "EXPIRES: @"$(jq -r '.expires' <<< $LEASE_INFO)
		# echo "CHECKOUT: " $(jq -r '.checkout' <<< $CHECKOUT)
		# echo "MORE_INFO: https://docs.nano.to/username-api"
		
		exit 1
	fi

	WHOIS=$(curl -s "https://nano.to/$2/account" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)

	# echo $WHOIS

	if [[ "$3" == "--set" ]] ; then

		if [[ $4 == 'banner' ]]; then

			if [[ $5 == 'file' ]] || [[ $5 == '--file' ]]; then
				# CONTENT=$()
				# echo $CONTENT
				EFD=$(curl -s "https://nano.to/cloud/username/$2" \
				-H "Accept: application/json" \
				-H "session: $(cat $DIR/.n2-session)" \
				-H "Content-Type:application/json" \
				--request POST \
				--data @<(cat <<EOF
{ "banner": "$(cat $6 | base64)" }
EOF
				))
				# echo $(cat $6)
				echo "${GREEN}Cloud${NC}: Banner uploaded."
				exit 1
			fi

		fi

		ODF=$(curl -s "https://nano.to/cloud/username/$2" \
-H "Accept: application/json" \
-H "session: $(cat $DIR/.n2-session)" \
-H "Content-Type:application/json" \
--request POST \
--data @<(cat <<EOF
{ "$4": "$5" }
EOF
))	
		if [[ $(jq -r '.error' <<< "$ODF") == '404' ]]; then
			#statements
			echo "${CYAN}Cloud${NC}: $(jq -r '.message' <<< "$ODF")"
			exit 1
		fi
		# echo "$ODF"
		echo "${GREEN}Cloud${NC}: Updated."
		exit 1
	fi

	if [[ $3 == "--prices" ]] || [[ $3 == "--price" ]]; then
		PRICE_CHECK=$(curl -s "https://nano.to/lease/$2" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)
		PLANS=$(jq -r '.plans' <<< "$PRICE_CHECK")
   echo "======================================="
   echo "USERNAME: @"$2
   echo "======================================="
		for row in $(echo "${PLANS}" | jq -r '.[] | @base64'); do
		    _jq() {
		     echo ${row} | base64 --decode | jq -r ${1}
		    }
		   echo "$(_jq '.name') ---------------- Ӿ $(_jq '.amount') "
		   # echo $(_jq '.amount')
		done
   echo "======================================="
   # echo "TIP: Use "
   # echo "======================================="
		exit 1
	fi

	if [[ $(jq -r '.error' <<< "$WHOIS") == "Username not registered." ]]; then

		if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
			echo $WHOIS
			exit 1
		fi
		

		if [[ "$3" == "buy" ]] || [[ "$3" == "lease" ]] || [[ "$3" == "purchase" ]]  || [[ "$3" == "--buy" ]] || [[ "$3" == "--purchase" ]]|| [[ "$3" == "--lease" ]] ; then
			
			if [[ $4 == "" ]]; then
				echo "${CYAN}Cloud${NC}: Missing duration."
cat <<EOF
Usage:
  $ n2 $1 $2 $3 --day
  $ n2 $1 $2 $3 --month
  $ n2 $1 $2 $3 --year
  $ n2 $1 $2 $3 --decade
EOF
				exit 1
			fi
		
   echo "======================================="
   echo "               NEW LEASE               "
   echo "======================================="
   echo "USERNAME: @"$2
   echo "======================================="
   echo "Manually set the nano address for      "
   echo "this Username. Default: Cloud Wallet   "
   echo "======================================="
	 read -p "${GREEN}Cloud${NC}: Nano Address (optional): " ADDRESS_GIVEN

		# read -p "${GREEN}Cloud${NC}: Are you sure you want to lease '@$2' for a '$4'. Funds are payed from Cloud Wallet on Nano.to. Enter 'y' to continue:" SANITY_CHECK

		# if [[ $SANITY_CHECK != 'y' ]] && [[ $SANITY_CHECK != 'Y' ]]; then
		# 	echo "Canceled."
		# 	exit 1
		# fi

			# /usr/local/bin/n2 version
		ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
		-H "Accept: application/json" \
		-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request GET)

		POW=$(curl -s "https://nano.to/$(jq -r '.frontier' <<< "$ACCOUNT")/pow" \
			-H "Accept: application/json" \
			-H "Content-Type:application/json" \
			--request GET)

		# echo $POW

		# exit 1

		if [[ $(jq -r '.error' <<< "$POW") == "429" ]]; then
			echo
			echo "==============================="
			echo "       USED ALL CREDITS        "
			echo "==============================="
			echo "  Use 'n2 buy pow' or wait.    "
			echo "==============================="
			echo
			return
		fi

		WORK=$(jq -r '.work' <<< "$POW")

		# CHECKOUT=$(curl -s "https://nano.to/cloud/lease/$2/$4?work=$WORK" \
		# 	-H "Accept: application/json" \
		# 	-H "session: $(cat $DIR/.n2-session)" \
		# 	-H "Content-Type:application/json" \
		# 	--request GET)

		LEASE_ATTEMPT=$(curl -s "https://nano.to/cloud/lease/$2" \
		-H "Accept: application/json" \
  	-H "session: $(cat $DIR/.n2-session)" \
		-H "Content-Type:application/json" \
		--request POST \
		--data @<(cat <<EOF
	{ "duration": "$4", "address": "$ADDRESS_GIVEN" }
EOF
		))

			# echo $LEASE_ATTEMPT

			echo "${GREEN}Cloud${NC}: Username Purchased."

			exit 1
		fi

		echo "==============================="
		echo "${GREEN}      USERNAME AVAILABLE ${NC}"
		echo "==============================="
		echo "USERNAME: @"$(jq -r '.username' <<< $CHECKOUT)
		echo "CHECKOUT: " $(jq -r '.checkout' <<< $CHECKOUT)
		echo "MORE_INFO: https://docs.nano.to/username-api"
		
		exit 1

	fi

	# echo $CHECKOUT

	if [[ "$3" == "buy" ]] || [[ "$3" == "lease" ]] || [[ "$3" == "purchase" ]]  || [[ "$3" == "--buy" ]] || [[ "$3" == "--purchase" ]]|| [[ "$3" == "--lease" ]] ; then
		echo "${CYAN}Cloud${NC}: This domain is taken."
		exit 1
	fi


	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
		echo $WHOIS
		exit 1
	fi

	WALLETS=$(jq -r '.accounts' <<< "$WHOIS")

	# echo
	echo "==============================="
	echo "          NANO LOOKUP          "
	echo "==============================="
	# echo "USERNAME: "$2
	echo "USERNAME: @"$(jq -r '.username' <<< $WHOIS) 
	# echo "BLOCKS: "$(jq -r '.height' <<< $WHOIS)
	echo "BALANCE: "$(jq -r '.balance' <<< $WHOIS)
	echo "ADDRESS: "$(jq -r '.address' <<< $WHOIS)
	echo "BROWSER: https://nanolooker.com/account/"$(jq -r '.address' <<< $WHOIS)
	echo "==============================="

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
		# read -p 'To (@Username or Address): ' $2
		echo "${CYAN}Cloud${NC}: Username, or Address missing."
cat <<EOF
Usage:
  $ n2 $1 @fosse 10
  $ n2 $1 @kraken 12.50 --json
EOF
		exit 1
	fi

	if [[ $3 == "" ]]; then
		echo "${CYAN}Cloud${NC}: Amount missing."
cat <<EOF
Usage:
  $ n2 $1 @fosse 10
  $ n2 $1 @kraken 12.50 --json
EOF
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



#  ██████╗ ██╗███████╗████████╗███████╗██╗  ██╗ ██████╗ ██████╗ 
# ██╔════╝ ██║██╔════╝╚══██╔══╝██╔════╝██║  ██║██╔═══██╗██╔══██╗
# ██║  ███╗██║█████╗     ██║   ███████╗███████║██║   ██║██████╔╝
# ██║   ██║██║██╔══╝     ██║   ╚════██║██╔══██║██║   ██║██╔═══╝ 
# ╚██████╔╝██║██║        ██║   ███████║██║  ██║╚██████╔╝██║     
#  ╚═════╝ ╚═╝╚═╝        ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     
                                                              

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
curl -s "https://nano.to/cloud/shop/address" \
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
curl -s "https://nano.to/cloud/shop/pow" \
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
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	if [[ $(jq -r '.code' <<< "$ACCOUNT") == "401" ]]; then
	rm $DIR/.n2-session
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



# ███████╗███╗   ███╗ █████╗ ██╗██╗     
# ██╔════╝████╗ ████║██╔══██╗██║██║     
# █████╗  ██╔████╔██║███████║██║██║     
# ██╔══╝  ██║╚██╔╝██║██╔══██║██║██║     
# ███████╗██║ ╚═╝ ██║██║  ██║██║███████╗
# ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝                          

if [[ "$2" = "email" ]] || [[ "$2" = "-email" ]] || [[ "$2" = "--email" ]] || [[ "$2" = "-e" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
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

if [[ "$1" = "key" ]] || [[ "$1" = "k" ]] || [[ "$1" = "-key" ]] || [[ "$1" = "-api" ]] || [[ "$1" = "--api" ]] || [[ "$2" = "-k" ]]; then

	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.n2-session)" \
	-H "Content-Type:application/json" \
	--request GET)

	# echo $ACCOUNT

	echo "==============================="
	echo "         CLI API KEY           "
	echo "==============================="
	echo "==============================="
	echo "Docs: https://docs.nano.to/pow "
	echo "==============================="

	# echo $(jq -r '.api_key' <<< "$ACCOUNT")

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
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
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
	if [[ $(cat $DIR/.n2-session 2>/dev/null) == "" ]]; then
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register'."
		exit 1
	else
		rm $DIR/.n2-session 2> /dev/null
		# echo "Ok:  of Nano.to."
		echo "${GREEN}Cloud${NC}: You logged out."
		exit 1
	fi
fi

# ██████╗ ███████╗ ██████╗██╗   ██╗ ██████╗██╗     ███████╗
# ██╔══██╗██╔════╝██╔════╝╚██╗ ██╔╝██╔════╝██║     ██╔════╝
# ██████╔╝█████╗  ██║      ╚████╔╝ ██║     ██║     █████╗  
# ██╔══██╗██╔══╝  ██║       ╚██╔╝  ██║     ██║     ██╔══╝  
# ██║  ██║███████╗╚██████╗   ██║   ╚██████╗███████╗███████╗
# ╚═╝  ╚═╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝╚══════╝╚══════╝                                                

if [[ $2 == "recycle" ]] ; then

	read -p 'Recyling a Nano address removes it from your wallet. Remaining funds are sent to your master Address: Type (y) to continue.'  YES

	if [[ $YES == "Yes" ]] || [[ $YES == "yes" ]]; then
		RECYCLE_ATTEMPT=$(curl -s "https://nano.to/cloud/recycle" \
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
		echo "${CYAN}Cloud${NC}: You're not logged in. Use 'n2 login' or 'n2 register' first."
		exit 1
	fi

	ACCOUNT=$(curl -s "https://nano.to/cloud/account" \
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

# cat <<EOF
# $LOCAL_DOCS
# EOF

# exit 1

# fi


# ██████╗ ██████╗ ██╗ ██████╗███████╗
# ██╔══██╗██╔══██╗██║██╔════╝██╔════╝
# ██████╔╝██████╔╝██║██║     █████╗  
# ██╔═══╝ ██╔══██╗██║██║     ██╔══╝  
# ██║     ██║  ██║██║╚██████╗███████╗
# ╚═╝     ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝                                  

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then



	if [[ "$2" == "--json" ]]; then
		curl -s "https://nano.to/price?currency=USD" \
		-H "Accept: application/json" \
		-H "Content-Type:application/json" \
		--request GET | jq
		exit 1
	fi

	# AWARD FOR CLEANEST METHOD
	PRICE=$(curl -s "https://nano.to/price?currency=$2" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET)
	# exit 1

	if [[ "$2" == "--json" ]] || [[ "$3" == "--json" ]] || [[ "$4" == "--json" ]] || [[ "$5" == "--json" ]] || [[ "$6" == "--json" ]]; then
		echo $PRICE
		exit 1
	fi

	echo "==============================="
	echo " NANO PRICE ($(jq -r '.currency' <<< "$PRICE")):" $(jq -r '.price' <<< "$PRICE")
	echo "==============================="
	# echo "SYMBOL:" $(jq -r '.price' <<< "$PRICE")
	echo "COINGECKO: https://www.coingecko.com/en/coins/nano/$(jq -r '.currency' <<< "$PRICE" | awk '{print tolower($0)}')"
	echo "COINMCAP: https://coinmarketcap.com/currencies/nano"

	exit 1

fi




# -----------------------------------ALIASES------------------------------------#     

# if [[ "$1" = "qrcode" ]]; then
# cat <<EOF
# Usage:
#   $ n2 cloud qrcode
#   $ n2 cloud qrcode @esteban 10 --json
# EOF
# 	exit 1
# fi

if [[ "$1" = "recycle" ]]; then
cat <<EOF
Usage:
  $ n2 cloud recycle
EOF
	exit 1
fi

# if [[ "$1" = "register" ]]; then
# cat <<EOF
# Usage:
#   $ n2 cloud register
# EOF
# 	exit 1
# fi

# if [[ "$1" = "logout" ]]; then
# cat <<EOF
# Usage:
#   $ n2 cloud logout
# EOF
# 	exit 1
# fi


# -----------------------------------BASEMENT------------------------------------#                                       


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
Nano.to
  $ n2 [ stats • price • login • register • account • username • 2fa • logout ]

Local Node (Non-Custodial)
  $ n2 local [ ls • send • qrcode • receive • install • upgrade • plugin ]

Cloud Node (Custodial)
  $ n2 cloud [ ls • send • qrcode • receive • recycle ]

Options
  $ n2 --update --version --dev --json
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
	if [ "$2" = "--dev" ]; then
		sudo rm /usr/local/bin/n2
		curl -s -L "https://github.com/fwd/n2/raw/dev/n2.sh" -o /usr/local/bin/n2
		sudo chmod +x /usr/local/bin/n2
		echo "Installed latest 'development' version."
		exit 1
	fi
	if [ "$2" = "--prod" ]; then
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
