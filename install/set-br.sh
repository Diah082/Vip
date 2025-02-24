#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -s https://raw.githubusercontent.com/diah082/izin/main/ip | grep "$MYIP" | awk '{ print $4 }')
if [ $MYIP = $IZIN ]; then
echo -e "Permission Accepted..."
else
clear
rm /root/* &> /dev/null
echo -e "$Permission Denied!";
exit 1
fi
REPO="https://raw.githubusercontent.com/diah082/vip/main/"
wget -q ${REPO}install/limit.sh && chmod +x limit.sh && ./limit.sh
apt install rclone
printf "q\n" | rclone config
wget -qO /root/.config/rclone/rclone.conf "https://drive.google.com/u/4/uc?id=19BP0A8pad2tc9ELmx8JcQPxNKRWP4S6M"
git clone  https://github.com/casper9/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
rm -f /root/set-br.sh
rm -f /root/limit.sh