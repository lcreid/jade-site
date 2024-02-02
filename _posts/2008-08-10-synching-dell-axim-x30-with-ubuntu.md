---
layout: post
title: Synching a Dell Axim X30 with Ubuntu
date: '2008-08-10T08:21:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- Lenovo x300
modified_time: '2008-08-10T08:36:42.479-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8328352292759367897
blogger_orig_url: http://technopragmatica.blogspot.com/2008/08/synching-dell-axim-x30-with-ubuntu.html
---

I have an old (?) Dell Axim X30 PDA that I use mainly as an address book
and MP3 player (I added a memory card so I can listen to podcasts while
walking the dog). Now that Ubuntu is my primary desktop OS, I wanted to
be synching contacts and sound files with Ubuntu.  
  
The [SynCE project][1] has done this. The documentation is pretty good,
but as usual I managed to make it hard for myself. Here's what I did:  
<ol><li>Make sure the X30 is <span style="font-style:
italic;">not</span> plugged in to the computer</li><li
style=\"font-family: courier new;\">sudo apt-get install synce-hal
librra0-tools librapi2-tools</li><li>Plug in the device</li><li
style=\"font-family: courier new;\">synce-pls</li></ol>The last line
should show what's in the top-level directory of the X30.  
  
Note that I was already running kernel 2.6.24-19, so I didn't have to
rebuild the modules as described in the documentation. If your Ubuntu
8.04 is up-to-date, you'll be running at least this kernel.  
  
My problem: All the installation instructions warn you to blacklist the
ipaq module if you have connection problems. So I went ahead and
blacklisted it before I even started. Then I fumbled around for a few
hours trying to connect unsuccessfully and searching for information.  
  
The X30 only supports Windows Mobile 2003 Second Edition. I don't know
all the technical details, but I know it means it used a somewhat
different protocol for connecting. In my search for answers, I found
enough examples of people successfully connecting to X30s that I kept
going. I also found enough references to the "old protocol" or "serial
protocol" that I finally realized I should try allowing the ipaq module.
I removed the blacklist and, presto, it worked.



[1]: http://www.synce.org/moin/FrontPage
