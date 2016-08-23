---
layout: post
title: "Deployment part 2 add SSH to github and VPS"
date: 2016-08-24 06:48:39 +0800
comments: true
categories:
---

## Enter SSH keys to VPS
1. After logging in as root user enter `sudo adduser deploy` and login with new user.

1. Add deplay user SSH key by enter `cat ~/.ssh/id_rsa.pub` in local machine and copy the keys

1. Enter `mkdir ~/.ssh` and `vi ~/.ssh/authorized_keys` in VPS in machine and copy the local keys to VPS

1. Now Retry ssh with deploy user

## Enter SSH keys to Github

1. In your VPS enter `ssh-keygen -t rsa` and press enter for all the questions

1. Enter `cat ~/.ssh/id_rsa.pub` and copy the keys

1. go to Github [SSH key page](https://github.com/settings/keys) and `New SSH key`

1. Paste the Ubuntu keys over

1. Then enter `ssh -T git@github.com` in your VPS and see if it's successfully connected to Github
