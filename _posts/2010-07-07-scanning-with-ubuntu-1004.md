---
layout: post
title: Scanning with Ubuntu 10.04
date: '2010-07-07T21:30:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2010-08-02T18:41:50.965-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1600613478688091612
blogger_orig_url: http://technopragmatica.blogspot.com/2010/07/scanning-with-ubuntu-1004.html
---

I have an HP CM1312nfi MFP multi-function colour printer, fax and
scanner. xsane worked fine in 9.04. The first time I tried to scan after
upgrading to Ubuntu 10.04 it didn't work anymore. (Breaking it may have
been something I did, rather than the upgrade itself.)  
  
First xsane told me that it couldn't find any devices. I reinstalled all
the hplip and xsane packages, and that got me a message that xsane
couldn't open the device -- giving a name that was obvious that it knew
about my scanner.  
  
I found a message in /var/log/syslog that xsane couldn't find the file
"/usr/share/hplip/scan/plugins/bb\_soapht.so". So I ran:  
<blockquote>sudo hp-plugin</blockquote>and answered the question about
license. Then xsane (and the new Simple Scan) worked.

