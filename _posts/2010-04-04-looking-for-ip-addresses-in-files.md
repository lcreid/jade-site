---
layout: post
title: Looking for IP Addresses in Files
date: '2010-04-04T07:20:00.000-07:00'
author: Larry Reid
tags:
- IT Infrastructure
modified_time: '2010-04-04T07:20:10.472-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7964850463109037114
blogger_orig_url: http://technopragmatica.blogspot.com/2010/04/looking-for-ip-addresses-in-files.html
---

| I've moved a couple of data centres. And I've virtualized a lot of servers. In all cases, the subnets in which the servers were installed changed. If anything depends on hard-coded IP addresses, it's going to break when the server moves.  
  
The next data centre I move, I'm going to search all the servers for files that contain hard-coded IP addresses. The simplest thing to do for Linux and Unix is this:  
<pre>egrep -R "\\b(\[\[:digit:\]\]\{1,3}.)\{3}\[\[:digit:\]\]\{1,3}\\b" *root\_of\_code*</pre>The regular expression matches one to three digits followed by a "." exactly three times, then matches one to three digits, with word boundaries at either end.  
  
That's not the most exact match of an IP address, because valid IP addresses won't have anything higher than 255 in each component. This is more correct:  
<pre>egrep -R "\\b((25\[0-5\] | 2\[0-4\]\[0-9\] | \[01\]?\[0-9\]\[0-9\]?).)\{3}(25\[0-5\] | 2\[0-4\]\[0-9\] | \[01\]?\[0-9\]\[0-9\]?)\\b" /!(tmp | proc | dev | lib | sys) &gt;/tmp/ips.out</pre>It yields about two percent fewer lines when scanning a Linux server (no GUI installed). (Thanks to [this awesome site][1] for the regular expression.)  
  
When I run the above egrep command from "/", I have problems. There are a few directories I had to exclude: /tmp, /proc, /dev, /lib and /sys. I used this file pattern match to get all the files in root except those directories:  
<pre>/!(tmp | proc | dev | lib | sys)</pre>The reason I wanted to exclude /tmp is that I wanted to put the output somewhere. /tmp is a good place, and by excluding it I didn't end up writing to the file while reading it. /sys on a Linux server has recursive directories in it. /proc and /dev have special files in them that cause egrep to simply wait forever. /lib also caused egrep to stop, but I'm not sure why (apparently certain combinations of regular expressions and files cause egrep to take a very long time -- perhaps that's what happened in /lib.)  
  
I'll write about how to do this for Windows in another post. I'll also write about how to do it across a large number of server. |



[1]: http://www.regular-expressions.info/examples.html
