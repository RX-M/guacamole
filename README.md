# RX-M Lab VM Guacamole Setup

Guacamole is separated into two pieces: guacamole-server, which provides the guacd proxy and related libraries, and
guacamole-client, which provides the client to be served by your servlet container, usually Tomcat.

guacamole-client is available in binary form, but guacamole-server (guacd) must (normally) be built from source, but we
are going to extract it from a container.


### 1. Install software & dependencies

Tomcat requires Java to be installed on the so that any Java web application code can be executed. We can satisfy that
requirement by installing OpenJDK. Guacamole relies on VNC and guacd has a number of dependencies for building and
runtime.

Update your apt-get package index and install Java, Tomcat, VNC and guacd dependencies:

```
user@ubuntu:~$ sudo apt-get update

user@ubuntu:~$ sudo apt-get install -y default-jdk tomcat8 vnc4server \
libcairo2-dev libjpeg-turbo8-dev libpng12-dev libossp-uuid-dev libvncserver-dev libwebp-dev
```

Install and/or update gnome components:

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

**</example>**


Create the `.vnc/` config directory, download and place the `xstartup` and `passwd` files:

```
user@ubuntu:~$ mkdir .vnc/

user@ubuntu:~$ wget -qO ~/.vnc/xstartup https://s3-us-west-1.amazonaws.com/rx-m-vms/guacamole/xstartup

user@ubuntu:~$ wget -qO ~/.vnc/passwd https://s3-us-west-1.amazonaws.com/rx-m-vms/guacamole/passwd
```


### 3. Set up VNC server as a systemd service

Download the pre-configured unit file:

```
user@ubuntu:~$ sudo wget -qO /etc/systemd/system/vncserver@.service \
https://s3-us-west-1.amazonaws.com/rx-m-vms/guacamole/vncserver%40.service
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

```
user@ubuntu:~$ cd /tmp

user@ubuntu:/tmp$ wget -q http://apache.claz.org/guacamole/0.9.14/source/guacamole-server-0.9.14.tar.gz

user@ubuntu:/tmp$ tar -xzf guacamole-server-0.9.14.tar.gz
```

Running `configure` will determine which libraries are available, selecting the appropriate components for building
depending on what is installed. The `--with-init-dir=` flag creates a startup script for guacd into the target
directory, so that we can configure guacd to start automatically on boot.

```
user@ubuntu:/tmp$ cd guacamole-server-0.9.14/

user@ubuntu:/tmp$ sudo mkdir /etc/guacamole

user@ubuntu:/tmp/guacamole-server-0.9.14$ ./configure --with-init-dir=/etc/guacamole

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

Guacamole releases page: https://guacamole.apache.org/releases/

The configuration file `guacamole.properties` contains instructions for Guacamole to connect to guacd:

```
user@ubuntu:~$ wget -qO /etc/guacamole/guacamole.properties \
https://s3-us-west-1.amazonaws.com/rx-m-vms/guacamole/guacamole.properties

```

Guacamole uses the `user-mapping.xml` to define which users are allowed to authenticate to the Guacamole web interface
(between <authorize> tags):

```
user@ubuntu:~$ wget -qO /etc/guacamole/user-mapping.xml \
https://s3-us-west-1.amazonaws.com/rx-m-vms/guacamole/user-mapping.xml
```

Create a symbolic link for Tomcat to be able to read the file:

```
user@ubuntu:~$ sudo mkdir /usr/share/tomcat8/.guacamole

user@ubuntu:$ sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole/
```








### 6/ Set up guacd as a systemd service

Download the pre-configured unit file from the guacamole-server GH repo:

```
user@ubuntu:~$ sudo wget -qO /etc/systemd/system/guacd.service.in \
https://raw.githubusercontent.com/apache/guacamole-server/master/src/guacd/systemd/guacd.service.in
```

Make the system aware of the new unit file:

```
user@ubuntu:~$ sudo systemctl daemon-reload
```

Enable the unit file:

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


















### 4. Start services



Set guacd to start before tomcat using guacd script at /etc/guacamole/guacd script

```
user@ubuntu:~$ sudo /usr/local/sbin/guacd &

user@ubuntu:~$ sudo systemctl restart tomcat8
```

Double check that it started without errors:

```
sudo systemctl status tomcat8
```









run vncserver and enter the password `ubuntu`:

```
user@ubuntu:~$ vncserver -geometry 1280x720

You will require a password to access your desktops.

Password: ubuntu
Verify: ubuntu

New 'ubuntu:1 (user)' desktop is ubuntu:1

Creating default startup script /home/user/.vnc/xstartup
Starting applications specified in /home/user/.vnc/xstartup
Log file is /home/user/.vnc/ubuntu:1.log

user@ubuntu:~$
```





Reload the systemd daemon so that it knows about our service file:

```
sudo systemctl daemon-reload
```

Start the Tomcat service:

```
sudo systemctl start tomcat
```
