if [ "$1" = "username" ] || [ "$1" = "lookup" ] || [ "$1" = "find" ] || [ "$1" = "whois" ] || [ "$1" = "search" ] || [ "$1" = "name" ] || [ "$1" = "-w" ] || [ "$1" = "-f" ]; then

    if [[ $2 == "" ]] || [[ "$3" == "--help" ]] ; then
cat <<EOF
Usage:
  $ n2 $1 @fosse
  $ n2 $1 @moon --json
  $ n2 $1 @moon --claim
  $ n2 $1 @moon --set website "James"
  $ n2 $1 @moon --set name "James"
EOF
        exit 1
    fi

    