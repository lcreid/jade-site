---
layout: post
title: Mount a USB Drive on Ubuntu 6.06.1
date: '2008-03-23T17:37:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2008-03-23T17:40:11.295-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7128195759541115222
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/mount-usb-drive-on-ubuntu-6061.html
---

If this is the first time, make yourself a mount point for USB devices,
like:  
  
<span style="font-family: courier new;">sudo mkdir /mnt/usb</span>  
  
Thereafter:  
  
<span style="font-family: courier new;">sudo mount /dev/sdb1
/mnt/usb</span>  
  
If mount can't figure out the filesystem type, you'll have to figure it
out yourself and specify the type to mount with the -t option.

