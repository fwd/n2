cat ./chunks/*.sh > ./n2.sh
file_size_kb=`du -k "./n2.sh" | cut -f1`
chmod +x ./n2.sh
echo "$(ls -1q ./chunks/* | wc -l | xargs) files,combined into one. ($file_size_kb kb)"

