#!/bin/bash
NAMA=$1
DOMAIN=$2
LOGFILE="/root/log_install_${NAMA}.log"
if [[ ! -f /root/Install.sh ]]; then
    wget -q https://raw.githubusercontent.com/Diah082/vip/main/Install.sh -O /root/Install.sh
    chmod +x /root/Install.sh
fi
nohup /root/Install.sh "$NAMA" "$DOMAIN" > "$LOGFILE" 2>&1 &
