cat ./source/*.sh > ./n2.sh
file_size_kb=`du -k "./n2.sh" | cut -f1`
chmod +x ./n2.sh
echo "$(ls -1q ./source/* | wc -l | xargs) files in source. Combined: ($file_size_kb kb)"

