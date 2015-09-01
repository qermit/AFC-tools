#!/bin/sh



# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
source ./ipmi_config.cfg


FLAG=1

function ctrl_c() {
        echo "** Trapped CTRL-C"
	FLAG=0	
}

#i=$((  (0x10 * 256 * 256 ) + (0x5d * 256 ) +  0x70));
i=0

while [ ${i} -lt 16777216 ]; do
    if [ ${FLAG} -eq 0 ]; then
	break
    fi

ADR0=$(( ${i} % 256))
ADR1=$(( (${i} / 256) % 256 ))
ADR2=$(( (${i} / 256) / 256 ))

printf "reading %02x %02x %02x:" ${ADR2} ${ADR1} ${ADR0}
PARAM="0x30 0x04 0x03 ${ADR2} ${ADR1} ${ADR0}"
${IPMI_CMD} ${PARAM}

i=$(( ${i} + 16 ))
done

