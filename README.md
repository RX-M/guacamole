![RX-M LLC][RX-M LLC]

# RX-M Lab VM Guacamole Setup

Using the base RX-M lab VM (see info [here](https://github.com/RX-M/classfiles/blob/master/lab-setup.md)), the following
instructions will get you through adding VNC and Apache Guacamole so that the VM can be accessed via a web browser.

Guacamole is separated into two pieces: guacamole-server, which provides the guacd proxy and related libraries, and
guacamole-client, which provides the client to be served by your servlet container, usually Tomcat.

guacamole-client is available as a WAR, but guacamole-server (guacd) must be built from source. Docker can be used but
we're not doing that here.


### 1. Install software & dependencies

Tomcat requires Java to be installed; we can satisfy that requirement by installing OpenJDK. Guacamole relies on VNC and
guacd has a number of dependencies to install.

Update your apt-get package index and install Java, Tomcat, VNC and guacd dependencies:

```
user@ubuntu:~$ sudo apt-get update

user@ubuntu:~$ sudo apt-get install -y default-jdk tomcat8 authbind vnc4server \
libcairo2-dev libjpeg-turbo8-dev libpng12-dev libossp-uuid-dev libvncserver-dev libwebp-dev
```

Install and/or update gnome components (our lab VM has a very minimal gnome install which unfortunately renders almost
nothing in VNC):

```
user@ubuntu:~$ sudo apt-get install --no-install-recommends ubuntu-desktop gnome-panel gnome-settings-daemon \
gnome-terminal gnome-flashback metacity nautilus
```


#### 2. VNC setup

VNC usually creates the `.vnc/` directory on first start but we're automating it. Here is an **example** of what was
done to initially generate the VNC config files.

**EXAMPLE ONLY! Do NOT perform**. Example of running vncserver and entering the password `ubuntu`:

```
user@ubuntu:~$ vncserver -geometry 1280x800 -depth 24

You will require a password to access your desktops.

Password: ubuntu
Verify: ubuntu

New 'ubuntu:1 (user)' desktop is ubuntu:1

Creating default startup script /home/user/.vnc/xstartup
Starting applications specified in /home/user/.vnc/xstartup
Log file is /home/user/.vnc/ubuntu:1.log

user@ubuntu:~$
```

**END example**


Create the `.vnc/` config directory, download and place the `xstartup` and `passwd` files:

```
user@ubuntu:~$ mkdir .vnc/

user@ubuntu:~$ wget -qO ~/.vnc/xstartup https://raw.githubusercontent.com/RX-M/guacamole/master/xstartup

user@ubuntu:~$ wget -qO ~/.vnc/passwd https://raw.githubusercontent.com/RX-M/guacamole/master/passwd
```


### 3. Set up VNC server as a systemd service

Download the pre-configured unit file from this repo:

```
user@ubuntu:~$ sudo wget -qO /etc/systemd/system/vncserver@.service \
https://raw.githubusercontent.com/RX-M/guacamole/master/vncserver%40.service
```

Make the system aware of the new unit file:

```
user@ubuntu:~$ sudo systemctl daemon-reload
```

Enable the unit file. The 1 following the @ sign signifies which display number the service should appear over, in this
case the default :1

```
user@ubuntu:~$ sudo systemctl enable vncserver@1.service
```

Start it as you would start any other systemd service:

```
user@ubuntu:~$ sudo systemctl start vncserver@1
```

Verify that it started:

```
sudo systemctl status vncserver@1
```


#### 4. Build guacd

Obtain a copy of the guacamole-server source and extract it:

> Guacamole releases page: https://guacamole.apache.org/releases/ for reference.

```
user@ubuntu:~$ cd /tmp

user@ubuntu:/tmp$ wget -q http://apache.claz.org/guacamole/0.9.14/source/guacamole-server-0.9.14.tar.gz

user@ubuntu:/tmp$ tar -xzf guacamole-server-0.9.14.tar.gz
```

Running `configure` will determine which libraries are available, selecting the appropriate components for building
depending on what is installed.

```
user@ubuntu:/tmp$ cd guacamole-server-0.9.14/

user@ubuntu:/tmp$ sudo mkdir /etc/guacamole

user@ubuntu:/tmp/guacamole-server-0.9.14$ ./configure

...

------------------------------------------------
guacamole-server version 0.9.14
------------------------------------------------

   Library status:

     freerdp ............. no
     pango ............... no
     libavcodec .......... no
     libavutil ........... no
     libssh2 ............. no
     libssl .............. no
     libswscale .......... no
     libtelnet ........... no
     libVNCServer ........ yes
     libvorbis ........... no
     libpulse ............ no
     libwebp ............. yes
     wsock32 ............. no

   Protocol support:

      RDP ....... no
      SSH ....... no
      Telnet .... no
      VNC ....... yes

   Services / tools:

      guacd ...... yes
      guacenc .... no

   Init scripts: /etc/systemd/system/

Type "make" to compile guacamole-server.

user@ubuntu:/tmp/guacamole-server-0.9.14$
```

Once configure is finished, just type "make", and it will guacamole-server will compile:

```
user@ubuntu:/tmp/guacamole-server-0.9.14$ make

...
```

Type `make install` to install the components that were built, and then `ldconfig` to update your system's cache of
installed libraries:

```
user@ubuntu:/tmp/guacamole-server-0.9.14$ sudo su

root@ubuntu:/tmp/guacamole-server-0.9.14# make install

root@ubuntu:/tmp/guacamole-server-0.9.14# ldconfig

root@ubuntu:/tmp/guacamole-server-0.9.14# exit
```


### 5. Guacamole/guacd configs

Download the web application archive for Guacamole, change its name to guacamole.war:

```
user@ubuntu:/tmp/guacamole-server-0.9.14$ cd ~

user@ubuntu:~$ sudo wget -qO /var/lib/tomcat8/webapps/guacamole.war \
http://apache.claz.org/guacamole/0.9.14/binary/guacamole-0.9.14.war
```

The configuration file `guacamole.properties` contains instructions for Guacamole to connect to guacd:

```
user@ubuntu:~$ wget -qO /etc/guacamole/guacamole.properties \
https://raw.githubusercontent.com/RX-M/guacamole/master/guacamole.properties

```

Guacamole uses the `user-mapping.xml` to define which users are allowed to authenticate to the Guacamole web interface
(between `<authorize>` tags):

```
user@ubuntu:~$ wget -qO /etc/guacamole/user-mapping.xml \
https://raw.githubusercontent.com/RX-M/guacamole/master/user-mapping.xml
```

Create a symbolic link for Tomcat to be able to read the file:

```
user@ubuntu:~$ sudo mkdir /usr/share/tomcat8/.guacamole

user@ubuntu:$ sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole/
```


### 6. Set up guacd as a systemd service

Download the pre-configured unit file:

```
user@ubuntu:~$ sudo wget -qO /etc/systemd/system/guacd.service \
https://raw.githubusercontent.com/RX-M/guacamole/master/guacd.service
```

Make the system aware of the new unit file:

```
user@ubuntu:~$ sudo systemctl daemon-reload
```

Enable the unit file:

```
user@ubuntu:~$ sudo systemctl enable guacd.service
```

Start it as you would start any other systemd service:

```
user@ubuntu:~$ sudo systemctl start guacd
```

Verify that it started:

```
user@ubuntu:~$ sudo systemctl status guacd
```


### 7. Configure Tomcat

Modify the Tomcat Connector port from 8080 to 80:

```
user@ubuntu:~$ sudo vim /etc/tomcat8/server.xml

...

    <!-- A "Connector" represents an endpoint by which requests are received
         and responses are returned. Documentation at :
         Java HTTP Connector: /docs/config/http.html (blocking & non-blocking)
         Java AJP  Connector: /docs/config/ajp.html
         APR (HTTP/AJP) Connector: /docs/apr.html
         Define a non-SSL/TLS HTTP/1.1 Connector on port 8080
    -->
    <Connector port="80" protocol="HTTP/1.1"
               connectionTimeout="20000"
               URIEncoding="UTF-8"
               redirectPort="8443" />

...
```

Run the following commands to provide tomcat7 read+execute on port 80:

```
user@ubuntu:~$ sudo touch /etc/authbind/byport/80

user@ubuntu:~$ sudo chmod 500 /etc/authbind/byport/80
```

Uncomment and change `#AUTHBIND=no` to yes

```
user@ubuntu:~$ sudo vim /etc/default/tomcat8

...

# If you run Tomcat on port numbers that are all higher than 1023, then you
# do not need authbind.  It is used for binding Tomcat to lower port numbers.
# (yes/no, default: no)
AUTHBIND=yes
```

Restart Tomcat:

```
user@ubuntu:~$ sudo systemctl restart tomcat8
```

Verify that it started:

```
user@ubuntu:~$ sudo systemctl status tomcat8
```

use netstat to confirm Tomcat is listening on 80:

```
user@ubuntu:~$ sudo netstat -ntlp

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 :::80                   :::*                    LISTEN      78741/java      

...
```

Go have some remote access fun via a browser at `http://<IP or FQDN or FQHN>/guacamole`

<br>

_Copyright (c) 2018 RX-M LLC, Cloud Native Consulting, all rights reserved_

[RX-M LLC]: http://rx-m.io/rxm-cnc.svg "RX-M LLC"
