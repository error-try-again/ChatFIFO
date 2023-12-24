# ChatGPT FIFO daemon
I was looking for a way to integrate the revChatGPT plugin with other Linux services & a forked version of the PopOS search launcher to get ChatGPT search results at the press of a button. 

By utilizing a FIFO implementation, information coming from the chat daemon is immediately written to a file, and in my case, the output is picked up by a forked version of the PopOS search launcher, which analyzes and looks at the responses and provides a notification accordingly. 

### Quickstart
### Step 1: Generate an API key
[from openai](https://platform.openai.com/account/api-keys)

### Step 2: Install Python
```bash
sudo apt install python3
```

### Step 3: Install revChatGPT using pip
```bash
python3 -m pip install --upgrade revChatGPT
```
[Link to gh source](https://github.com/openai/chatgpt-retrieval-plugin)

### Step 4: Verify your configuration
```bash
python3 -m revChatGPT.V3 --api_key <your_new_api_key>
```

### Step 5: Add your key to the code
```python
...
def chat_daemon():
    api_key = "your_api_key"
    chatbot = Chatbot(api_key=api_key)
...
```

### Step 6: Grant executable permissions to your script where it's installed
```bash
chmod +x ~/.local/bin/chat.py
chmod +x ~/.local/bin/worker.py
```
### Step 7: Run
```bash 
gpt.sh whats your favourite food
```

### Advanced Pt 1: ChatGPT for the PopOS! Launcher

[Here is an experimental fork of the popos launcher.](https://github.com/error-try-again/launcher)

1. Git Setup

```bash
git clone https://github.com/error-try-again/launcher.git && cd launcher
git checkout search-plugin && git pull origin search-plugin && git fetch
```

2. Rust Setup (if not installed/configured)

```bash
sudo apt install just
curl https://sh.rustup.rs -sSf | bash -s -- -y --no-modify-path
```

```bash
export PATH="$HOME/.cargo/env"
```

```bash
rustc --version
```

```bash
apt-get install libxkbcommon-x11-dev libglvnd-dev --yes
```


2. Compile & Install

```bash
just build-release && just plugins="search" install
```

3. Usage

`watch -n 1 'cat /tmp/chat.log'`

Super Key/Whatever yours is bound to

*Type* 
`!gpt whats your favourite food`


### Advanced Pt 2 (experimental): Manipulate the base/system prompt
*this alters all future GPT prompts*

Find the following line in chat.py and modify the text accordingly. 

```
 chatbot = Chatbot(api_key=api_key, engine="gpt-3.5-turbo",
                      system_prompt="You're a Tea expert, respond accordingly.")
```

# Example

[Screencast from 05-23-2023 01:43:33 PM.webm](https://github.com/error-try-again/chatgpt-fifo-daemon/assets/19685177/5629f2cc-10fe-49bd-9e63-d03734a78b7f)
