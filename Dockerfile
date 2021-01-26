FROM demydiuk/domoticz:latest

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends python3-pip sshpass iputils-ping ffmpeg openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# For Domoticz_iDetect v2
RUN pip3 install paramiko
