---
layout: post
title: Citrix in a Window on Linux
date: '2016-07-19T06:40:00.001-07:00'
author: Larry Reid
tags:
- Citrix
modified_time: '2016-07-20T10:23:01.600-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-807783436925050931
blogger_orig_url: http://technopragmatica.blogspot.com/2016/07/citrix-in-window-on-linux.html
---

[Edit: This was not the solution. It worked the first time, but now it isn't working again.]

I was using Citrix Receiver quite successfully on Ubuntu 16.04 and Linux Mint 13 to remotely access my customer's network, but I couldn't make it start in a window. It was coming up in full screen mode. I could minimize the whole Citrix session by doing Ctrl-F2 (to tell Receiver to pass the next key to Linux), then Ctrl-Super-downarrow (Super is the "Windows" key). However, I wanted to be able to watch the Citrix session on one monitor, while I worked on other stuff on the other monitor.

I finally found this blog that told me how to set up the Receiver config files to get Receiver to start in a window:&nbsp;<a href="http://blog.eek-a-geek.info/2014/10/citrix-receiver-for-linux-131-on-64-bit.html">http://blog.eek-a-geek.info/2014/10/citrix-receiver-for-linux-131-on-64-bit.html</a>. What it says is:

Edit `~/.ICAClient/All_Regions.ini`, replacing the line `TWIMode=*` to `TWIMode=Off`.

Edit `~/.ICAClient/wfclient.ini`, adding a line `TWIMode=off` to the `[WFClient]` section, and adding a line `UseFullScreen=True` to the `[Thinwire3.0]` section.
