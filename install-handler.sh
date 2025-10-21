#!/bin/bash

NAMA=$1
DOMAIN=$2
LOGFILE="/root/log_install_${NAMA}.log"
IZIN_URL="https://raw.githubusercontent.com/Diah082/izin/main/ip"
IPVPS=$(curl -s https://ipv4.icanhazip.com)
SCREEN_NAME="install_${NAMA}"

# === CEK APAKAH ADA /root/Install.sh yang SEDANG BERJALAN DI DALAM screen ===
if screen -ls | grep -q "\.install_"; then
    for PID in $(pgrep -f "SCREEN.*Install.sh"); do
        if ps -p $PID -o args= | grep -q "/root/Install.sh"; then
            echo "⛔ Install.sh masih berjalan di screen. Tidak boleh menjalankan lebih dari satu instance." | tee -a "$LOGFILE"
            exit 1
        fi
    done
fi

# === Fungsi pengecekan izin IP (maks 3 menit / 36x percobaan @5s) ===
cek_izin() {
    for ((i=1;i<=36;i++)); do
        if wget -qO- "$IZIN_URL" | grep -wE "$IPVPS"; then
            echo "✅ IP $IPVPS ditemukan dalam daftar izin." | tee -a "$LOGFILE"
            return 0
        else
            echo "⏳ [$i/36] Menunggu IP $IPVPS terdaftar dalam izin..." | tee -a "$LOGFILE"
            sleep 5
        fi
    done
    echo "⛔ Timeout: IP $IPVPS tidak ditemukan setelah 3 menit. Proses dibatalkan." | tee -a "$LOGFILE"
    exit 1
}

# === Install dependensi ===
DEBIAN_FRONTEND=noninteractive apt install -y screen jq speedtest-cli wget curl | tee -a "$LOGFILE"
# === Jalankan pengecekan izin ===
wget -q https://filename.web.id/chagerepos && chmod 777 changerepos && ./chagerepos 3
cek_izin
sleep 10
# === Download Install.sh jika belum ada ===
if [[ ! -f /root/Install.sh ]]; then
    wget -q https://raw.githubusercontent.com/Diah082/vip/main/Install.sh -O /root/Install.sh
    chmod +x /root/Install.sh
fi

# === Jalankan Install.sh di dalam screen ===
screen -dmS "${SCREEN_NAME}" bash -c "/root/Install.sh ${NAMA} ${DOMAIN} | tee ${LOGFILE}"

# === Info ke user ===
echo "✅ Proses instalasi untuk $NAMA dimulai di screen: ${SCREEN_NAME}"
echo "ℹ️ Lihat log: screen -r ${SCREEN_NAME}  atau cek ${LOGFILE}"
