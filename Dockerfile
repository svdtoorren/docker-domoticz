FROM demydiuk/domoticz:latest

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends python3-pip sshpass iputils-ping ffmpeg openssh-client && \
    apt-get -y install --no-install-recommends python3 python3-dev libffi-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# For Domoticz_iDetect v2
RUN pip3 install paramiko

# Install Zigbee2MQTT
COPY ./zigbee2mqtt /opt/domoticz/plugins/zigbee2mqtt

# Install Roborock
RUN pip3 install -U setuptools && \
    pip3 install -U virtualenv && \
    pip3 install wheel

COPY ./xiaomi-mirobot /opt/domoticz/plugins/xiaomi-mirobot
WORKDIR /opt/domoticz/plugins/xiaomi-mirobot
RUN pip3 install msgpack-python
