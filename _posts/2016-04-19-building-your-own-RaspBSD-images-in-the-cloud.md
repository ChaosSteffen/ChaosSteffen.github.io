---
layout: post
title: Building your own RaspBSD images in the cloud
---

[RaspBSD](http://raspbsd.org) is a great way to get some hands on experience with [FreeBSD](https://www.freebsd.org) without any need to touch your local system. But RaspBSD is based on the [FreeBSD 11-CURRENT](https://www.freebsd.org/relnotes/CURRENT/relnotes/article.html) branch, which is under active development.

So at some point I wanted to build my own SD card image, but compiling on your local machine can be very time consuming, which is why I used a cloud service for that.

The following guide was created using a virtual FreeBSD instance from DigitalOcean, but should also work on any other service like EC2 or on your local FreeBSD machine.

### 1. Create a new FreeBSD instance and login
Go to [https://www.digitalocean.com](www.digitalocean.com/?refcode=39f0d520c166) (referal link, feel free to not use it) and sign up.

Create a new instance (they call it "droplet") and choose FreeBSD 10.2. The size just depends on how long you are willing to wait. Note: you can resize your instance late to use more cores and ram.

Now, login via ssh.

### 2. Install all prerequisites
Let's start by installing all the necessary software:

```
sudo portsnap fetch extract
sudo portsnap fetch update

sudo pkg install -y git nano tmux python u-boot-rpi
```

Now, start a tmux session because the following commands can be a bit long running:

```
tmux new
```

We'll need the most recent FreeBSD source code:

```
sudo svnlite checkout svn://svn.freebsd.org/base/head /usr/src
sudo svnlite update /usr/src
```

The crochet-tool is used to handle the compiling and generation of the SD card image:

```
git clone https://github.com/freebsd/crochet.git ~/crochet
```

### 3. Configure and Compile the image
First create a config file and edit to your needs:

```
cd ~/crochet
cp config.sh.sample config.rpi.sh
nano config.rpi.sh
```

The config file is pretty straight forward, uncomment the type of board you are building for and if you don't know better keep the default options.

The following command starts the compile process and can take very long. (Between 20 min and a couple of hours, depending on which instance type you chose.)

```
/bin/sh crochet.sh -c config.rpi.sh
```

### 4. Download your image and transfer to your SD card
The ```crochet.sh```-script will output the name of your brand new SD card image.

Now download it to your local machine and copy it to the SD card:

```
sudo dd if=FreeBSD-armv6-11.0-RPI-B-297268.img of=/dev/disk2 bs=1m
```

Enjoy!
