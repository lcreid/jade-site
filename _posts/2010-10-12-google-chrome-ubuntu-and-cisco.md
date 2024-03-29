---
layout: post
title: Google Chrome, Ubuntu, and Cisco AnyConnect
date: '2010-10-12T18:34:00.000-07:00'
author: Larry Reid
tags:
- VPN
- Ubuntu
modified_time: '2011-10-01T06:46:33.991-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-964869112117798236
blogger_orig_url: http://technopragmatica.blogspot.com/2010/10/google-chrome-ubuntu-and-cisco.html
---

I need to use Cisco's AnyConnect VPN client. It's worked quite well with
FireFox on Ubuntu, although I had to forgo the upgrade to 9.10 because
the VPN client wouldn't work with the kernels that came with 9.10. (That
wasn't the only reason I didn't go to 9.10, so I wasn't really bothered
by it.)  
  
I've been using Google Chrome for the last few weeks instead of FireFox.
It is noticeably faster on my Lenovo x300. Going back to FireFox seems
excruciatingly slow. I decided to try Chrome with the Cisco VPN client.
It's not officially supported, but both FireFox and Chrome are supposed
to support standards, so what could be the problem?  
  
It worked on my Lenovo with Ubuntu 10.04, but when I tried it on my
netbook with Ubuntu Netbook Remix 10.04, it didn't work. It would get to
the point where the client is supposed to actually start, and then
nothing would happen.  
  
I finally noticed that on the Lenovo, I had the IcedTea plugin
installed, whereas on the netbook I was trying to do exactly what was
supported by Cisco (Sun Java and some fiddling to get the plugin
working). So I installed IcedTea on the netbook, and it worked just
fine.  
  
To install IcedTea, start System-&gt; Adminstration-&gt; Synaptic
Package Manager, enter your password, then put "icedtea" in the "Search"
field. Right click on "icedtea6-plugin", select "Mark for installation"
and then click on the "Apply" button. Or, if you like the Terminal, type
"sudo apt-get install icedtea6-plugin" in a terminal.  
  
(Update for Ubuntu 11.04: the package to install is called
"icedtea-plugin" now. No version number.)  
  
It's always fun when you try to do something exactly by the book and it
doesn't work, and then you do it the way you think should work, and it
does.  
  
Unfortunately, Exchange 2010 Outlook Web Access doesn't support Chrome,
so I'm forced to use the crippled "Lite" interface. So I'll probably end
up using FireFox anyway.

