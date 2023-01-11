#!/bin/bash
echo  "#Architecture: $(uname -a)"
echo  "#CPU physical : $(lscpu  | grep Socket | awk '{print $2}')"
echo  "#vCPU : $(lscpu  | grep vcpu | awk '{print $2}')"
fram=$(free -m | awk 'NR == 2 {print $2}')
uram=$(free -m | awk 'NR == 2 {print $3}')
pram=$(free | awk 'NR == 2 {printf("%.2f"), $3/$2*100}')
echo  "#Memory Usage: $uram/${fram}MB ($pram%)"
echo  "#Disk Usage: $(df -m | grep "/dev/" | grep -v "boot" | awk '{avai += $2} {use += $3} END  {printf("%d/%dGB (%.2f%%)"), use ,avai/1024 ,(use*100)/avai}')"
echo  "#CPU load: $(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')"
echo  "#Last boot: $(who -b | awk 'NR == "1" {print $3 " " $4}')"
var=$(lsblk | grep lvm | wc -l)
echo  "#LVM use: $(if [ $var -gt 0 ]
then
        echo yes
else
        echo no
        fi)"
echo "#Connections TCP : $(cat /proc/net/sockstat{,6} | awk 'NR == "1" {print  $3}')" ESTABLISHED""
echo "#user log : $(users | wc -w)"
echo "#Network: IP $(hostname -I) ($(ip link show  | awk ' NR == 4 {print $2}'))"
echo "#Sudo : $(journalctl -q _COMM=sudo | grep COMMAND | wc -l )" "cmd"
