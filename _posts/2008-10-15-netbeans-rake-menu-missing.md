---
layout: post
title: Netbeans Rake Menu Missing
date: '2008-10-15T19:32:00.000-07:00'
author: Larry Reid
tags:
- Ruby on Rails
- NetBeans
modified_time: '2008-10-15T20:01:23.510-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3928099476395853888
blogger_orig_url: http://technopragmatica.blogspot.com/2008/10/netbeans-rake-menu-missing.html
---

In NetBeans 6.1, I created a new project and the "Run Rake Tasks" menu
was empty (it only said "Refresh List"). I found someone else through
Google who had the same problem, but no solution other than "use
NetBeans 6.5 beta".  
  
After fooling around a bit, I simply un-installed Rails 2.1.1 and
re-installed it and voila, the "Run Rake Tasks" menu was populated with
all its tasks. Bizarre.   
  
P.S. It wasn't completely random that I chose to re-install Rails 2.1.1.
When I tried to check on the plug-ins I had installed, I got a message
that said to install Rails 2.1.1. My gems list said it was already
installed, so I decided to un-install it and then install.

