#!/usr/bin/env bash

if [[ $# < 1 ]]; then
    echo "usage: ./analyser.sh <log_file>"
fi

INPUT_FILE=$1
OUTPUT_COUNT=5

# IP addresses
echo "top $OUTPUT_COUNT IP addresses"
cat $INPUT_FILE | cut -f1 -d " " | sort | uniq -c | sort -r | head -n $OUTPUT_COUNT | awk '{ print $2" - "$1 " requests" }'

# Requested paths
echo
echo "top $OUTPUT_COUNT requested paths"
cat $INPUT_FILE | cut -f7 -d " " | sort | uniq -c | sort -r | head -n $OUTPUT_COUNT | awk '{ print $2" - "$1 " requests" }'

# Status codes
echo
echo "top $OUTPUT_COUNT status codes"
cat $INPUT_FILE | cut -f3 -d "\"" | cut -f2 -d " " | sort | uniq -c | sort -r | head -n $OUTPUT_COUNT | awk '{ print $2" - "$1 " requests" }'

# User agents
echo
echo "top $OUTPUT_COUNT user agents"
cat $INPUT_FILE | rev  | cut -f1-3 -d "\"" | rev | tr -d "\"" | cut -f2 -d " "  | sort | uniq -c | sort -r | head -n $OUTPUT_COUNT | awk '{ print $2" - "$1 " requests" }'
