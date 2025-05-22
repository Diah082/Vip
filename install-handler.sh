#!/bin/bash

# Argumen dari bot
NAMA=$1
DOMAIN=$2

# Cek parameter
if [[ -z "$NAMA" || -z "$DOMAIN" ]]; then
  echo "❌ Penggunaan: ./install-handler.sh <nama> <domain>"
  exit 1
fi

# Cek dan unduh installer utama
if [[ ! -f /root/Install.sh ]]; then
  wget -q https://raw.githubusercontent.com/Diah082/vip/main/Install.sh -O /root/Install.sh
fi

chmod +x /root/Install.sh

# Buat log file
LOG_FILE="/root/log_install_${NAMA}.log"

# Jalankan script dalam screen dari dalam VPS
screen -dmS install_${nama} bash -c "/root/Install.sh ${nama} ${domain} | tee /root/log_install_${nama}.log"
echo "✅ Proses instalasi untuk $NAMA dimulai di screen: install_${NAMA}"
echo "ℹ️ Lihat log: screen -r install_${NAMA}  atau cek /root/log_install_${NAMA}.log"

