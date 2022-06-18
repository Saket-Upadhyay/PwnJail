#/bin/bash

# MIT License
# Copyright (c) 2022 Saket Upadhyay

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

PORT=1337

check_port() {
        echo "[+] Checking instance port ..."
        netstat -tlpn | grep "\b$1\b"
}

if check_port $PORT
then
  echo    "Your challenge is running, Have fun with pwn!\nPress 1 Restart your challenge\nPress 2 to do nothing\n Input your choice: "
  read -p "Your challenge is running, Have fun with pwn!\nPress 1 Restart your challenge\nPress 2 to do nothing\n Input your choice: " choice 
  echo $choice
  if [ "$choice" = "1" ]
	then
    kill -9 $(ps aux | grep 'challengebin' | awk '{print $2}')
    sleep 5;
  else
    echo "Go on..."
  fi
else
  echo "[+] Ready to start to your challenge"
  kill -9 $(ps aux | grep 'nsjail' | awk '{print $2}')
  nsjail --config /etc/nsjail.cfg -d
fi
