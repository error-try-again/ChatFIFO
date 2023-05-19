#!/bin/bash

# Check if the Python script is running and kill it
if [ -f /tmp/chat.pid ]; then
    kill $(cat /tmp/chat.pid) 2>/dev/null
    rm /tmp/chat.pid
fi

# Starting the chat.py script
python3 ~/.local/bin/chat.py &

# Loop through the command-line arguments and send them to in_fifo
for arg in "$@"; do
    echo "$arg" > /tmp/in_fifo
done

# Join all command-line arguments with spaces into a single query
query=$(printf "%s " "$@")
echo "$query" > /tmp/in_fifo

# Read the output from out_fifo
while IFS= read -r line; do
    line=$(echo "$line" | iconv -f utf-8 -t utf-8 -c)
    notify-send "$line"
done < /tmp/out_fifo
