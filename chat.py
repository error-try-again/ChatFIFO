#!/usr/bin/env python3

import argparse
import os
import traceback

from revChatGPT.V3 import Chatbot

IN_FIFO = '/tmp/in_fifo'
OUT_FIFO = '/tmp/out_fifo'

# Ensure the IN_FIFO exists
if not os.path.exists(IN_FIFO):
    os.mkfifo(IN_FIFO)

# Ensure the OUT_FIFO exists
if not os.path.exists(OUT_FIFO):
    os.mkfifo(OUT_FIFO)


def chat_daemon():
    api_key = "your_api_key"
    chatbot = Chatbot(api_key=api_key)

    with open(IN_FIFO, 'r') as in_fifo:
        with open(OUT_FIFO, 'w') as out_fifo:
            while True:
                try:
                    query = in_fifo.readline().strip()
                    if query:  # Only ask the chatbot if query is not empty
                        response = chatbot.ask(query)
                        out_fifo.write(response + '\n')
                    out_fifo.flush()  # Ensure the response gets written immediately
                except Exception as e:
                    out_fifo.write('ERROR: ' + str(e) + '\n')
                    out_fifo.write(traceback.format_exc())
                    out_fifo.flush()


def main():
    chat_daemon()


if __name__ == "__main__":
    main()
