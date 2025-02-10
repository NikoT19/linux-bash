#!/bin/bash
#open_wifi_scan/sh
#cheack have nmcli

if !command -v nmcli &>/dev/null; then
    echo "nmcli have not. Install  NetworkManager."
    exit 1
fi

echo "scan open wifi net..."
# using nmcli terse reg
# output SSID, SEC, SIG, RATE
# filter line where SEC ipul too "--"
nmcli -t -f SSID, SECURITY, SIGNAL, RATE device wifi list | \
awk -F: '($2== "" || $2=="--") {print}' | \
sort -t: -k3 -nr | \
awk -F: 'BEGIN{
    printf "%-30s %-10s %-10s\n", "SSID", "RATE", "SIGNAL", "SECURITY"
}
{
ssid=($1 ==""?"Hidden":$1)
rate=($4==""?"n/a":$4)
signal=$3
security=($2==""?"OPEN":$2)
printf "%-30s %-10s %-10s %-10\n", ssid, rate signal, security
}'