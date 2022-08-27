
LOCAL_DOCS=$(cat <<EOF
${GREEN}USAGE:${NC}
 $ n2 setup
 $ n2 balance
 $ n2 whois @moon
 $ n2 send @esteban 0.1
 $ n2 install (Coming Soon)
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
$ n2 setup
$ n2 balance
$ n2 send @esteban 0.1 ADDRESS
$ n2 whois @moon
EOF
)

if [[ $1 == "" ]] || [[ $1 == "help" ]] || [[ $1 == "list" ]] || [[ $1 == "--help" ]]; then
  echo "${GREEN}BALANCE:${NC} 40.20"
  echo "${GREEN}PENDING:${NC} 0.00"
  echo "${GREEN}ACCOUNT:${NC} nano_j33kjdkd***"
  echo "${GREEN}SYNCING:${NC} 100%"
  echo "${GREEN}VERSION:${NC} Nano Node V23.3"
  echo "${GREEN}RPC-CLI:${NC} N2 $VERSION"
	exit 0
fi

if [[ "$1" = "--json" ]]; then
	echo "Tip: Use the '--json' flag to get command responses in JSON."
	exit 0
fi
