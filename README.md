# freekers/docker-domoticz

This is a fork of linuxserver/docker-domoticz with personal customizations: ffmpeg, sshpass and iputils have been added as alpine packages to support RTSP streams, “keyboard-interactive” password authentication for use with the iDetect presence detection plugin and iputils for custom watchdog scripts.

The images are automatically updated if new code is committed to linuxserver's Github repository. Additionally, the images are rebuild whenever the base image is updated on Docker Hub (i.e. linuxserver:docker-domoticz).

## Usage

```
docker create \
  --name=domoticz \
  --net=bridge \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  -p 1443:1443 \
  -p 6144:6144 \
  -p 8080:8080 \
  --device=<path to device> \
  freekers/docker-domoticz
```

You can choose between using tags, latest (default, and no tag required), or a specific stable version of domoticz.

#### Tags

This image provides various versions that are available via tags. `latest` tag usually provides the latest stable version. Others are considered under development and caution must be exercised when using them.

| Tag | Description |
| :----: | --- |
| latest | Current latest head from master at https://github.com/domoticz/domoticz. |
| stable | Latest stable version. |
| stable-4.9700 | Old stable version. Will not be updated anymore! |

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 1443` - the port(s)
* `-p 6144` - the port(s)
* `-p 8080` - the port(s)
* `-v /config` - location for the config files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `--device` - for passing through USB devices
* `-e TZ` - for timezone information *eg Europe/London, etc*

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it domoticz /bin/bash`.

### Passing Through USB Devices

To get full use of Domoticz, you probably have a USB device you want to pass through. To figure out which device to pass through, you have to connect the device and look in dmesg for the device node created. Issue the command 'dmesg | tail' after you connected your device and you should see something like below.

```
usb 1-1.2: new full-speed USB device number 7 using ehci-pci
ftdi_sio 1-1.2:1.0: FTDI USB Serial Device converter detected
usb 1-1.2: Detected FT232RL
usb 1-1.2: FTDI USB Serial Device converter now attached to ttyUSB0
```

As you can see above, the device node created is ttyUSB0. It does not say where, but it's almost always in /dev/. The correct tag for passing through this USB device is '--device=/dev/ttyUSB0'

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

To configure Domoticz, go to the IP of your docker host on the port you configured (default 8080), and add your hardware in Setup > Hardware.

## Info

* Shell access whilst the container is running: `docker exec -it domoticz /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f domoticz`

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' domoticz`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' freekers/docker-domoticz`
