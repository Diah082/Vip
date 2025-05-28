#!/bin/bash
NAMA=$1
DOMAIN=$2
LOGFILE="/root/log_install_${NAMA}.log"
apt install -y screen jq speedtest-cli wget curl | tee ${LOG_FILE}
if [[ ! -f /root/Install.sh ]]; then
    wget -q https://raw.githubusercontent.com/Diah082/vip/main/Install.sh -O /root/Install.sh
    chmod +x /root/Install.sh
fi
screen -dmS install_${NAMA} bash -c "/root/Install.sh ${NAMA} ${DOMAIN} | tee ${LOG_FILE}"
echo "✅ Proses instalasi untuk $NAMA dimulai di screen: install_${NAMA}"
echo "ℹ️ Lihat log: screen -r install_${NAMA}  atau cek /root/log_install_${NAMA}.log"
