# Openhab - socat Docker

## Introduction
This let you use socat with the original openhab docker image. Please refer to the original openhab image to know how to configure the openhab part

## Socat
If I take the example of openhab image like:
```
docker run \
  --name openhab \
  --net=host \
  --tty \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v /opt/openhab/addons:/openhab/addons \
  -v /opt/openhab/conf:/openhab/conf \
  -v /opt/openhab/userdata:/openhab/userdata \
  openhab/openhab:2.3.0-amd64-debian
```

Here updated for use with socat:

```
docker run \
  --name openhab \
  --net=host \
  --tty \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v /opt/openhab/addons:/openhab/addons \
  -v /opt/openhab/conf:/openhab/conf \
  -v /opt/openhab/userdata:/openhab/userdata \
  -v /opt/socat/socat-ttyNET0.cont:/etc/supervisor/conf.d/socat-ttyNET0.conf
  -v /opt/socat/socat-ttyNET1.cont:/etc/supervisor/conf.d/socat-ttyNET1.conf
  clempat/socat-openhab:2.3.0-amd64-debian
```

Exemple of socat-{port}.conf - This is a conf for supervisord see [the supervisord doc](http://supervisord.org/installing.html#creating-a-configuration-file)
```
[program:socat]
command=/usr/bin/socat -d -d pty,link=/dev/ttyNET0,raw,user=openhab,group=dialout,mode=777 tcp:<ip-address>:<port>
user=openhab
autorestart=true
```

Then Adjust the EXTRA_JAVA_OPTS accordingly
```
EXTRA_JAVA_OPTS="-Dgnu.io.rxtx.SerialPorts=/dev/ttyUSB0:/dev/ttyS0:/dev/ttyS2:/dev/ttyACM0:/dev/ttyAMA0:/dev/ttyNET0"
```

Then you have to log into the Karaf console (see also the openHAB Documentation) and install the serial transport. Simply enter the following.

```
feature:install openhab-transport-serial
logout
```
