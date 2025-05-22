#!/bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

border() {
  echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
}

border_mid() {
  echo -e "${RED}╠══════════════════════════════════════════════════════════════╣${NC}"
}

border_bot() {
  echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
}

display_info() {
  clear
  ascii_art
  border

  echo -e "${YELLOW}┃ Hostname       :${NC} $(hostname)"
  echo -e "${YELLOW}┃ Uptime         :${NC} $(uptime -p | sed 's/up //')"
  echo -e "${YELLOW}┃ Date & Time    :${NC} $(date '+%Y-%m-%d %H:%M:%S')"

  border_mid

  # CPU
  CPU_MODEL=$(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2- | sed 's/^[ \t]*//')
  echo -e "${YELLOW}┃ CPU Model      :${NC} $CPU_MODEL"

  # Memory
  MEM_TOTAL=$(free -m | awk 'NR==2{print $2}')
  MEM_USED=$(free -m | awk 'NR==2{print $3}')
  MEM_PCT=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
  echo -e "${YELLOW}┃ RAM Usage      :${NC} ${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PCT}%)"

  # Disk
  DISK_USE=$(df -h / | awk 'NR==2{print $3 " / " $2 " (" $5 ")"}')
  echo -e "${YELLOW}┃ Disk Usage     :${NC} $DISK_USE"

  border_mid

 
  if command -v curl >/dev/null 2>&1; then
    ISP=$(curl -s ipinfo.io/org | cut -d' ' -f2-)
    REGION=$(curl -s ipinfo.io/region)
    IP=$(curl -s ipinfo.io/ip)
  else
    ISP="curl not installed"
    REGION="?"
    IP="?"
  fi

  echo -e "${YELLOW}┃ Public IP      :${NC} $IP"
  echo -e "${YELLOW}┃ ISP            :${NC} $ISP"
  echo -e "${YELLOW}┃ Region         :${NC} $REGION"

  border_bot
  echo -e "${YELLOW}┃ TERIMAKASIH SUDAH ORDER PANEL KAMI${NC}"
  echo -e "${YELLOW}┃ JALANKAN PERINTAH DI 'TYPE A COMMAN'${NC}"
}
display_info
if [ "$#" -gt 0 ]; then
  exec "$@"
else
  exec "/bin/bash"
fi