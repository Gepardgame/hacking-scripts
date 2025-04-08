#!/bin/bash

function contains() {
	[[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && echo 1 || echo 0
}

function file-transfer() {
	protocols="http ftp smb"
	OPTIND=1
	while getopts "s:p:" opt; do
		case $opt in
		s) protocol=$OPTARG ;;
		p) port=$OPTARG ;;
		\?) echo -e "\e[31m-s for protocol type and -p for port" && return 1 ;;
		esac
	done

	if [ $(contains "$protocols" "$protocol") -ne 1 ]; then
		echo -e "\e[31mProtocol is no available!"
		return 1
	fi

	if [[ ! "$port" =~ ^[0-9]+$ ]] || ((port < 0 || port > 65535)); then
		echo -e "\e[31mPort is not a number or is to big"
		return 1
	fi

	echo 11
	case $protocol in
	"http") updog -p "$port" ;;
	"ftp") python -m pyftpdlib -p "$port" -w ;;
	"smb") smbserver.py -port "$port" test . ;;
	esac
}
