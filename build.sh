cat ./chunks/*.sh > ./n2.sh
file_size_kb=`du -k "./n2.sh" | cut -f1`
echo "$(ls -1q ./chunks/* | wc -l | xargs) files,combined into one. ./n1.sh ($file_size_kb kb)"

