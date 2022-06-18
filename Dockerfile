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


FROM ubuntu:18.04
# you can also use ubuntu:latest ; 18.04 also works well.

LABEL maintainer="saketupadhyay"

# Update Ubuntu and Install important packages/tools
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y update && apt-get install -y \
    autoconf \
    bison \
    flex \
    gcc \
    g++ \
    git \
    netcat \
    net-tools \
    socat \
    libprotobuf-dev \
    libnl-route-3-dev \
    libtool \
    make \
    pkg-config \
    protobuf-compiler \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Setting up SSH
RUN rm -f /etc/service/sshd/down
RUN export LC_ALL=C
RUN export DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure openssh-server
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config

# Adding CTF users / low priv. users
RUN groupadd ctf && \
    useradd -g ctf ctf -m -s /bin/bash && \
    password=$(openssl passwd -1 -salt 'abcdefg' 'aefei7UR') && \
    sed -i 's/^ctf:!/ctf:'$password'/g' /etc/shadow

RUN useradd challenger 


# Building NS Jail
COPY ./bin/nsjail/ /nsjail
RUN cd /nsjail && make && mv /nsjail/nsjail /bin/pwnjail
RUN rm -rf /nsjail

# Setting up directories
RUN mkdir /home/packages && chown ctf:ctf /home/packages
WORKDIR /home/ctf/challenge

# Setting up challenge binary
COPY ./chal /home/ctf/challenge

# Adding chllenge file and flag

# This will give any binary you import a general name- "challengebin"
RUN mv /home/ctf/challenge/* /home/ctf/challenge/challengebin
RUN chown -R root:ctf /home/ctf/challenge
RUN chmod -R 775 /home/ctf/challenge

WORKDIR /home/ctf

COPY ./flag /home/ctf/flag
RUN chmod 644 /home/ctf/flag && chown root:root /home/ctf

# Copying some essential scripts

ADD ./bin/rerun.sh /
RUN chmod 755 /rerun.sh

ADD ./bin/pwnjailexec.sh /
RUN chmod +x /pwnjailexec.sh

ADD ./bin/start.sh /etc/my_init.d/
RUN chmod u+x /etc/my_init.d/start.sh

# Adding pwnjail configuration from ./bin/pwnjail.cfg
ADD ./bin/pwnjail.cfg /etc/
RUN chmod 644 /etc/pwnjail.cfg

# Exposing port 1337 for communication; change this if needed
EXPOSE 1337
