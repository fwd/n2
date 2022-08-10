
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
${GREEN}USAGE:${NC}
$ n2 whois @moon --json
$ n2 node setup
$ n2 node balance
${GREEN}OPTIONS:${NC}
--help, -h  N2 Documentation.
--docs, -d  Nano.to Docs.
--update, -u  Update N2.
--version, -v  Print N2 Version.
--uninstall, -u  Remove N2.
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
