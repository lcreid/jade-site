---
layout: post
title: Changing IP of Brother Scanner Under Linux
date: '2016-12-23T08:31:00.001-08:00'
author: Larry Reid
tags:
modified_time: '2016-12-23T08:31:04.473-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7235078470781949020
blogger_orig_url: http://technopragmatica.blogspot.com/2016/12/changing-ip-of-brother-scanner-under.html
---

We had a power outage this week. Some devices on my home network got new IP addresses when the power came back on. One of the devices that got a new IP address was my Brother MFC-9340CDW printer/scanner/fax. The printer was still working fine, but I couldn't scan.

The tl;dr is to remove the old configuration and set the new one:
```
sudo brsaneconfig4 -r MFC-9340CDW
sudo brsaneconfig4 -a name=MFC-9340CDW model=MFC-9340CDW ip=192.168.0.124
```
I got the new IP address from poking buttons on the front panel of the printer. The name of the device may be different, but the above is what I had from the default setup. `brsaneconfig4 -q` gives all the devices supported, and also the last line is the current configuration. That's useful to see what the currently configured IP address is, according to the software on the computer.

To figure out what was wrong with `simple-scan`, I did this in a terminal to see debugging output:
```
simple-scan -d
```
Another useful command is:
```
brsaneconfig4 -p
```
which runs `ping` on the scanner. However, in my case another device had the scanner's old IP address, so the `ping` appeared to be working fine.
