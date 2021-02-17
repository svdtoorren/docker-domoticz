FROM linuxserver/domoticz:latest

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends python3 python3-dev libffi-dev libssl-dev git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone plugins
ENV pluginsdir=/config/plugins
RUN git clone -b master --depth 1 --single-branch https://github.com/stas-demydiuk/domoticz-zigbee2mqtt-plugin.git ${pluginsdir}/zigbee2mqtt && \
    git clone -b master --depth 1 --single-branch https://github.com/mrin/domoticz-mirobot-plugin.git ${pluginsdir}/xiaomi-mirobot

# Install Roborock
RUN pip3 install -U setuptools && \
    pip3 install -U virtualenv && \
    pip3 install wheel

WORKDIR ${pluginsdir}/xiaomi-mirobot
RUN pip3 install msgpack-python
