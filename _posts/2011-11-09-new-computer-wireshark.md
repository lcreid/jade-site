---
layout: post
title: A New Computer -- Wireshark
date: '2011-11-09T14:22:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
- New Computer
modified_time: '2011-11-09T14:22:49.875-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4320625106288178747
blogger_orig_url: http://technopragmatica.blogspot.com/2011/11/new-computer-wireshark.html
---

I'm not a network expert by any stretch of the imagination, but
I've occasionally solved problems by poking around a bit with
[Wireshark][1].  
  
Of course, if my network is down I'm not going to be able to download
Wireshark. Fortunately, I remembered to re-install Wireshark on my new
computer *before* I needed it. I installed it using the Ubuntu Software
Centre.  
  
A new feature of Wireshark that I didn't know about: If you add yourself
to the "wireshark" group, you can do live captures without running
Wireshark as root.  
  
`sudo adduser --disabled-login --disabled-password wiresharksudo chgrp
wireshark /usr/bin/dumpcapsudo chmod 754 /usr/bin/dumpcapsudo setcap
'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap`  
  
Now add yourself to the wireshark group and log out. When you log back
in you should be able to do live captures without root privileges. To
add yourself to the wireshark group in a terminal, type:  
  
`adduser your-user-name wireshark`  
 The Wireshark documentation for this is [here][2] (scroll down a bit).



[1]: http://www.wireshark.org/
[2]: http://wiki.wireshark.org/CaptureSetup/CapturePrivileges
