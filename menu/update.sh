#!/bin/bash
cd
wget -qO updatesc.sh "http://getbot.nevpn.my.id:3050/update.sh"
chmod +x updatesc.sh
./updatesc.sh
rm -- "$0"
