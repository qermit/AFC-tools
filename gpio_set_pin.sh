#!/bin/sh

source ./ipmi_config.cfg

PORT=${1}
MODE=2
PIN=${2}
VALUE=${3}


${IPMI_CMD} 0x30 0x01 ${PORT} ${MODE} ${PIN} ${VALUE}
