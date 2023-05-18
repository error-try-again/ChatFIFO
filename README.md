# ChatGPT FIFO daemon
FIFO daemon for integrating revChatGPT plugin with Linux systems written in python

## Why?
I was looking for a way to glue various chatbot implementations to Linux services & various Rust projects. I built 3-ish implementations, and this was my favourite for its simplicity.

## Quickstart
## Step 1: Generate an API key
[from openai](https://platform.openai.com/account/api-keys)

## Step 2: Install Python
```bash
sudo apt install python3
```

## Step 3: Install revChatGPT using pip
```bash
python3 -m pip install --upgrade revChatGPT
```
[You can also download the source code from the Github page](https://github.com/openai/chatgpt-retrieval-plugin)

## Step 4: Verify your configuration
```bash
python3 -m revChatGPT.V3 --api_key <your_new_api_key>
```

## Step 4.1: Add your key to the code
```python
...
def chat_daemon():
    api_key = "your_api_key"
    chatbot = Chatbot(api_key=api_key)
...
```

## Step 5: Grant executable permissions to your script where it's installed
```bash
chmod +x ~/.local/bin/chat.py
```


## Step 5: Run daemon
```bash
nohup python3 ~/.local/bin/chat.py &
```

## Step 5: Optional: Add systemctl configuration (out of scope)


# Usage

## To Write
/bin/bash -c 'echo $MY_QUESTION > /tmp/in_fifo'

## To Read
cat /tmp/out_fifo

## Gif of a launcher integration I built on top of [a WIP search feature](https://github.com/canadaduane/launcher/tree/search-plugin) from POP-OS
![WIP2](https://github.com/error-try-again/chatgpt-fifo-daemon/assets/19685177/8085456a-ff85-45fc-a2f8-caf3c8975b3b)

