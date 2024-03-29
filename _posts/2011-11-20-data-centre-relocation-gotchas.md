---
layout: post
title: Data Centre Relocation Gotchas
date: '2011-11-20T21:46:00.001-08:00'
author: Larry Reid
tags:
- Relocation
modified_time: '2011-11-20T22:17:03.284-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6298838615824616046
blogger_orig_url: http://technopragmatica.blogspot.com/2011/11/data-centre-relocation-gotchas.html
---

Here are a couple of gotchas we ran into while relocating close a
medium-size data centre:  
  
<ul><li>When restarting a server in its new location, it decided to do a
chkdsk. Unfortunately, the volume was a 10 TB SAN LUN. Fortunately, we
had a long weekend to move that particular server, so we could wait the
almost two days it took for the chkdsk to run. (I don't know why the
server decided to do chkdsk. Rumour has it we didn't shut down the
server cleanly because a service wouldn't stop.) </li><li>A website
tells me to run "<span style="background-color: white;
border-bottom-width: 0px; border-color: initial; border-left-width: 0px;
border-right-width: 0px; border-style: initial; border-top-width: 0px;
color: #222222; margin-bottom: 0px; margin-left: 0px; margin-right: 0px;
margin-top: 0px; padding-bottom: 0px; padding-left: 0px; padding-right:
0px; padding-top: 0px;"><span class="Apple-style-span"
style="font-family: inherit;">fsutil dirty query c:" to see if chkdsk is
going to run on the C: drive the next time the system
boots</span></span></li><li><span style="background-color: white;
border-bottom-width: 0px; border-color: initial; border-left-width: 0px;
border-right-width: 0px; border-style: initial; border-top-width: 0px;
color: #222222; margin-bottom: 0px; margin-left: 0px; margin-right: 0px;
margin-top: 0px; padding-bottom: 0px; padding-left: 0px; padding-right:
0px; padding-top: 0px;"><span class="Apple-style-span"
style="font-family: inherit;">On Linux, [here][1]{: target="_blank"} are
a couple of ways to make sure you won't have an fsck when you restart
the server</span></span></li><li>We were frequently burned by the
Windows "feature" to automatically add a server to DNS when the server
starts up. Either we'd get DNS changes when we weren't ready for them,
or we'd get the wrong changes put into DNS. For example, servers that
have multiple IPs on one NIC, where only one of the IPs should have been
in DNS</li></ul>Here's a short checklist for turning off and moving a
server:  
  
<ul><li>Check to see if the server is going to check file system
consistency on the next startup (chkdsk or fsck)</li><li>Shut the server
down cleanly</li><li>If it's a physical server, shut it down and then
restart it. Rumour has it that the hard drive can freeze up if the
server hasn't been stopped in a long while. Better to find that out
before you move it than after. This has never happened to me</li><li>Do
a host or nslookup after starting the server to make sure your DNS
entries are correct. Make sure the entry is correct and that you have
the right number of entries (usually one)</li></ul>



[1]: http://idolinux.blogspot.com/2008/08/prevent-on-boot-fsck-for-critical.html
