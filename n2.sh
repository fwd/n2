#!/bin/bash

DIR=$(eval echo "~$different_user")

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
Usage
  $ ./n2.sh login
  $ ./n2.sh register
  $ ./n2.sh account
  $ ./n2.sh logout

Options
  --help, -h  Print documentation.
  --version, -v  Print CLI version.
END_HEREDOC
)


if [[ $1 == "login" ]]; then

	echo "$BANNER"

	USERNAME=$2
	PASSWORD=$3

	if [[ $USERNAME == "" ]]; then
		read -p 'Email: ' USERNAME
	fi

	if [[ $USERNAME == "" ]]; then
		read -sp 'Password: ' PASSWORD
	fi

	SESSION=$(curl -s "https://nano.to/login" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request POST \
	--data @<(cat <<EOF
{ "username": "$USERNAME", "password": "$PASSWORD" }
EOF
	))

	if [[ $(jq '.session' <<< "$SESSION") == null ]]; then
		echo "Error:" $(jq '.message' <<< "$SESSION")
		exit 1
	fi

	rm $DIR/.nano_to_session

	echo $(jq -r '.session' <<< "$SESSION") >> $DIR/.nano_to_session

	echo

	echo "You are now logged in."

	exit 1

fi

if [[ $1 == "register" ]]; then

	echo "$BANNER"

	echo 

	echo 'Welcome aboard'

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

if [ "$1" = "price" ] || [ "$1" = "--price" ] || [ "$1" = "-price" ] || [ "$1" = "p" ] || [ "$1" = "-p" ]; then

	curl -s "https://nano.to/price" \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	--request GET | jq
	exit 1

fi

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

if [[ "$1" = "account" ]]; then

	if [[ $(cat $DIR/.nano_to_session 2>/dev/null) == "" ]]; then
		echo "Error: You're not logged in."
		exit 1
	fi

	curl -s "https://nano.to/__account" \
	-H "Accept: application/json" \
	-H "session: $(cat $DIR/.nano_to_session)" \
	-H "Content-Type:application/json" \
	--request GET | jq
	exit 1

fi

if [[ "$1" = "logout" ]]; then
	rm $DIR/.nano_to_session
	echo "Done: You've logged out."
	exit 1
fi

if [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-help" ] || [ "$1" = "-h" ]; then
	echo "$DOCS"
	exit 1
fi

if [ "$1" = "-v" ] || [ "$1" = "--version" ] || [ "$1" = "version" ]; then
	echo "$VERSION"
	exit 1
fi

if [ "$1" = "-u" ] || [ "$1" = "--update" ] || [ "$1" = "update" ]; then
	curl -s -L "https://github.com/fwd/n2/raw/master/n2.sh" -o /usr/local/bin/n2
	sudo chmod +x /usr/local/bin/n2
	exit 1
fi

echo "$DOCS"