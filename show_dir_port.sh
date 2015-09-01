#!/bin/sh

source ./ipmi_config.cfg

PORT=${1}
MODE=0

read -a a <<< $(${IPMI_CMD} 0x30 0x01 ${PORT} ${MODE})


D2B=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})

for i in {0..7}; do
a[$i]="0x${a[${i}]}" ;
#echo ${a[${i}]} ${D2B[${a[${i}]}]}

done

echo  "Port Direction: 0x$x${a[3]}${a[2]}${a[1]}${a[0]}   ${D2B[${a[3]}]} ${D2B[${a[2]}]} ${D2B[${a[1]}]} ${D2B[${a[0]}]}"
echo  "Port Value    : 0x$x${a[7]}${a[6]}${a[5]}${a[4]}   ${D2B[${a[7]}]} ${D2B[${a[6]}]} ${D2B[${a[5]}]} ${D2B[${a[4]}]}"
#echo "Port Value:     $x${a[7]}${a[6]}${a[5]}${a[4]}"
#MP=$a[3]
#cho ${a[3]} ${D2B[${a[3]}]]}


