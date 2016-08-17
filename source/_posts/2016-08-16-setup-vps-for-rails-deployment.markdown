---
layout: post
title: "Setup VPS for Rails Deployment Part 1"
date: 2016-08-16 19:55:08 +0800
comments: true
categories:
---
First Sign up Linode or Digital Ocean.
Sign up for the 10$ plan, location: whereever closest to you,
Select Ubunto 14.04 x64

1. Copy the IP address and enter `ssh root@xxx.xxx.xxx.xxx` and enter password
1. Update Ubunto  `#$ sudo apt-get update`, `#$ sudo apt-get upgrade`, `#$ sudo apt-get autoremove`
1. Set TimeZone `#$ sudo dpkg-reconfigure tzdata` Asia, Taipei
1. Install utf-8 Language：`#$ sudo locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 en_US.UTF-8`
1. Install Mysql  - `#$ sudo apt-get install mysql-common mysql-client libmysqlclient-dev mysql-server`
    - test `#$ mysql -u root -p` see if mysql successfully installed
1. Install Git and following dependencies `#$ sudo apt-get install build-essential git-core curl libssl-dev libreadline5 libreadline-gplv2-dev zlib1g zlib1g-dev libmysqlclient-dev libcurl4-openssl-dev libxslt-dev libxml2-dev libffi-dev git`
1.  rvm： `\curl -sSL https://get.rvm.io | bash`
1. exit and enter Ubunto again
1. Install ruby 2.3.0 `rvm install 2.3.0`
1. Install ImageMagic `sudo apt-get install imagemagick` (reenter the command to check if ImageMagic has been install)
1. Install Nginx `sudo apt-get install nginx -y`
    - link Nginx config link to your project `sudo rm /etc/nginx/sites-enabled/default`
    - `sudo ln -nfs "/home/deploy/KaohsiungRubbishTruck/current/config/nginx.conf" "/etc/nginx/sites-enabled/KaohsiungRubbishTruck"` (change KaohsiungRubbishTruck to your project)
1. Install Rails `gem install rails -v '5.0.0' -V --no-ri --no-rdoc`
1. Install Bundler `gem install bundler -V --no-ri --no-rdoc`
