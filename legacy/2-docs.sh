
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
${GREEN}CLOUD:${NC}
  $ n2 [ login • register • account • 2factor • logout ]
${GREEN}NAMES:${NC}
  $ n2 username @esteban [ buy • renew • config • claim ]
  $ n2 username @moon --buy --day
  $ n2 username @moon --set email "support@nano.to"
  $ n2 username @moon --set website --file ./index.html
${GREEN}WALLET:${NC}
  $ n2 receive
  $ n2 send @esteban 0.1
  $ n2 pow @esteban --json
${GREEN}N2 CLI:${NC}
  $ n2 --update --version --dev --json
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
