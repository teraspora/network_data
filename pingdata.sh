#!/bin/bash

# pingdata.sh

usage() {
    echo "Script to gather connection stats by pinging a server regularly and saving the data to a file."
    echo "Usage: $0 [-p|--ip <IP>] [-i|--interval <seconds>] [-f|--output <filename>]"
    echo "Example: ./pingdata.sh --ip f.rootserver.net -i 5 -o testrootf.log"
    exit 1
}

short_opts="p:i:o:"
long_opts="ip:,interval:,output:"

parsed_opts=$(getopt -o "$short_opts" --long "$long_opts" -n "$(basename "$0")" -- "$@")

if [ $? -ne 0 ]; then
    usage
    echo "Error parsing options. Exiting."
    exit 1
fi

eval set -- "$parsed_opts"

ip=''
interval=''
outfile=''

while true; do
# echo -e "Dollar 012345: $0 $1 $2 $3 $4 $5 \n========================================\n"
    case "$1" in
        -p | --ip) ip="$2"; shift ;;
        -i | --interval) interval="$2"; shift ;;
        -o | --output) outfile="$2"; shift ;;
        --) shift; break ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

echo "Pinging $ip every $interval seconds.   Saving to $outfile.   Press Ctrl+C to kill."
echo -e "\nPinging $ip\n" >> $outfile

ping -i $interval $ip | \
    stdbuf -oL \
        awk -F'[:=]' '/time=/{ cmd="date +%H:%M:%S"; cmd | getline date; close(cmd); print date, substr($5, 1, length($5)-3) }' \
>> $outfile
