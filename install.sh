#!/data/data/com.termux/files/usr/bin/bash

pkg update -y
pkg upgrade -y

pkg install git python nodejs make -y

python -m pip install pycryptodome

cd "$HOME"

if [ -d "butterfly-" ]; then
    cd butterfly-
    git pull
else
    git clone https://github.com/mave3188/butterfly-.git
    cd butterfly-
fi

npm install -g @whiskeysockets/baileys pino qrcode-terminal

exec make run