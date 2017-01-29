#!/bin/bash

#####
#
# Monitoring plugin to check, if a given IP address is blacklisted in SNDS.
#
# Copyright (c) 2017 Jan Vonde <mail@jan-von.de>
#
#
# Usage: ./check_snds.sh -i 1.2.3.4 -k aaa-bbb-ccc-111-222-333
#
# 
# For more information visit https://github.com/janvonde/check_snds
#####


USAGE="Usage: check_snds.sh -i [IP] -k [KEY]"

if [ $# -ge 4 ]; then
	while getopts "i:k:"  OPCOES; do
		case $OPCOES in
			i ) IP=$OPTARG;;
			k ) KEY=$OPTARG;;
			* ) echo "$USAGE"
			     exit 1;;
		esac
	done
else 
	echo "$USAGE"; exit 3
fi


## check if needed programs are installed
type -P curl &>/dev/null || { echo "ERROR: curl is required but seems not to be installed.  Aborting." >&2; exit 1; }
type -P sed &>/dev/null || { echo "ERROR: sed is required but seems not to be installed.  Aborting." >&2; exit 1; }


## get ipStatus from SNDS
SNDSFILE=$(curl -s https://postmaster.live.com/snds/ipStatus.aspx?key="${KEY}")


## check if IP is included in SNDSFILE
if [[ ${SNDSFILE} =~ .*$IP.* ]]; then
	CAUSE=$(echo "${SNDSFILE}" | grep "${IP}" | cut -d, -f4)
	echo "ERROR: IP ${IP} is blacklisted +++ ${CAUSE}"
	exit 2
else
	echo "OK: IP ${IP} is not blacklisted on SNDS"
fi
