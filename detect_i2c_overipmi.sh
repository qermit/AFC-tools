#!/bin/bash

source ./ipmi_config.cfg

detect_i2c_ipmi() {



PARAM="0x30 0 0 0x40 0 1"
I2C_BUS=${1}



printf "Probing available I2C devices using bus %d ..." ${I2C_BUS}
printf "\n     00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F"
printf "\n===================================================="
for i in {0..127}; do
if [[ $((i % 16)) -eq 0 ]]; then
	printf "\n%02X  "  $((i / 16 ))
fi
if [[ ${i} -le 7 || ${i} -gt 120 ]]; then
printf "   "
continue
fi

read -a OUT <<< $(${IPMI_CMD} 0x30 0x00 ${I2C_BUS} $((i)) 0x00 0x01)
if [[ "x${OUT[1]}" == "x01" ]]; then
printf " %02X" $((i))
else
printf " --"
fi

done
printf "\n"

}

if [ $# -ne 1 ]; then
detect_i2c_ipmi "0x00"
detect_i2c_ipmi "0x01"
detect_i2c_ipmi "0x02"
else
detect_i2c_ipmi "${1}"
fi
