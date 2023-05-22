#!/bin/bash

# Check if the Python script is running and terminate it
if [ -f /tmp/chat.pid ]; then
    kill $(cat /tmp/chat.pid) 2>/dev/null
    rm /tmp/chat.pid
fi

# Start the chat.py script
python3 ~/.local/bin/chat.py &

# Send the command-line arguments to the input FIFO (in_fifo)
for arg in "$@"; do
    echo "$arg" > /tmp/in_fifo
done

sleep 3

# Read the output from the output FIFO (out_fifo)
while IFS= read -r line; do
    # Cleanse the line by converting encoding to UTF-8 and remove invalid characters
    line=$(echo "$line" | iconv -f utf-8 -t utf-8 -c)

    # Display the line as a notification and append it to the chat log
    notify-send "$line" && echo "$line" >> /tmp/chat.log
done < /tmp/out_fifo
