cat ./chunks/*.sh > ./n2
file_size_kb=`du -k "./n2" | cut -f1`
chmod +x ./n2
echo "$(ls -1q ./chunks/* | wc -l | xargs) files,combined into one. ($file_size_kb kb)"

