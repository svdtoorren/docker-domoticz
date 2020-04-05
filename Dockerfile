# New base image as LS.IO was not updated yet
FROM demydiuk/domoticz:latest
RUN apt-get update && apt-get install -y python3-pip sshpass iputils-ping ffmpeg
# For Domoticz_iDetect v2
RUN pip3 install paramiko
