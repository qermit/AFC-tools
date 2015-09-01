#!/bin/bash

source ./ipmi_config.cfg
FPGA_CMD_DPRAM_READ="0x03"
FPGA_CMD_DPRAM_WRITE="0x02"
FPGA_CMD_WBONE_READ="0x13"
FPGA_CMD_WBONE_WRITE="0x12"
FPGA_CMD_RDID="0x9F"

SPI_ID=1
NETFN="0x30"
CMD="0x05"

# param1 address
# param2 length
addr_to_str(){
ADDRESS=${1}
LENGTH=${2}

ADDR_STR=""
declare -a ADDR_A
PTR=0
while [ ${PTR} -lt ${LENGTH} ]; do
	ADDR_A[${PTR}]=$(( (${ADDRESS} >> (${PTR}* 8)) & 0x000000FF ))
	ADDR_STR="${ADDR_A[${PTR}]} ${ADDR_STR}"
	PTR=$((PTR +1 ))

done
echo -n ${ADDR_STR}
return 0
}

ADDRESS=0
if [ ${#} -gt 0 ]; then
ADDRESS=${1}
fi;
ADDR=$(addr_to_str ${ADDRESS} 2)

WRITE=0



PARAM_RDID="${NETFN} ${CMD} ${SPI_ID} 0x01 0x03 ${FPGA_CMD_RDID}"
PARAM="${NETFN} ${CMD} ${SPI_ID} 0x03 0x04 0x00 ${ADDR}"

if [ ${#} -eq 2 ]; then
	WRITE=1
	VALUE=$(addr_to_str ${2} 4)
	PARAM="${NETFN} ${CMD} ${SPI_ID} 0x08 0x00 0x80 ${ADDR} ${VALUE}"
fi

read -a VALUE_A <<< $(${IPMI_CMD} ${PARAM})
if [ ${WRITE} -eq 0 ]; then
echo "REG ${ADDRESS}:  0x${VALUE_A[0]}${VALUE_A[1]}${VALUE_A[2]}${VALUE_A[3]}"
fi

