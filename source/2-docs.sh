
DOCS=$(cat <<EOF
${GREEN}Usage:${NC}
$ n2 whois @moon --json
$ n2 qrcode @fosse
$ n2 node setup
$ n2 node balance
$ n2 username @lightyear --buy --year
$ n2 username @lightyear --set --email "support@lightyear.com"
$ n2 username @lightyear --set --website ./index.html
${GREEN}Flags:${NC}
  --help, -h  Print N2 Documentation.
  --docs, -d  Open Nano.to Docs.
  --update, -u  Update N2 Script.
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
