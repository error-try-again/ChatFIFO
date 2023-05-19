#!/bin/bash

# Check if the Python script is running and kill it
if [ -f /tmp/chat.pid ]; then
    kill $(cat /tmp/chat.pid) 2>/dev/null
    rm /tmp/chat.pid
fi

# Starting the chat.py script
python3 ~/.local/bin/chat.py &

# Send the command-line arguments to in_fifo
for arg in "$@"; do
    echo "$arg" > /tmp/in_fifo
done

sleep 3

# Read the output from out_fifo
while IFS= read -r line; do
    line=$(echo "$line" | iconv -f utf-8 -t utf-8 -c)
    notify-send "$line"
done < /tmp/out_fifo
