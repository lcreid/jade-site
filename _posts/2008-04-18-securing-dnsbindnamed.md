---
layout: post
title: Securing DNS/bind/named
date: '2008-04-18T20:48:00.000-07:00'
author: Larry Reid
tags:
- named
- dns
- bind
- IT Infrastructure
modified_time: '2011-11-19T15:50:08.441-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7055120417845622347
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/securing-dnsbindnamed.html
---

This is another late posting of some notes when I built some new
infrastructure servers on VMs to replace my aging PowerPC Macs that ran
my network.  
  
The security info I got when my ISP told me I had a badly configured
name server requires that you create a /var/named directory:  
  
`sudo mkdir /var/named `  
`sudo chgrp bind /var/named `  
`sudo chmod 770 /var/named `  
`sudo chmod g+s /var/named `  
`sudo mkdir /var/log/named `  
`sudo chmod 770 /var/log/named `  
`sudo chmod g+s /var/log/named `

