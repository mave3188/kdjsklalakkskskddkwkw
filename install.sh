#!/data/data/com.termux/files/usr/bin/bash

set -e

pkg update -y
pkg upgrade -y

pkg install git python nodejs make -y


python -m pip install pycryptodome

git clone https://github.com/mave3188/butterfly-

cd "$HOME/butterfly-"

npm install -g @whiskeysockets/baileys pino qrcode-terminal

make run