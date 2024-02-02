---
layout: post
title: The Java Gotcha for Data Centre Relocations
date: '2011-11-27T07:12:00.001-08:00'
author: Larry Reid
tags:
- Relocation
modified_time: '2013-06-05T07:47:41.977-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1278123451080082793
blogger_orig_url: http://technopragmatica.blogspot.com/2011/11/java-gotcha-for-data-centre-relocations.html
---

Way back in time, someone thought it would be a good idea for the Java
run-time to cache DNS look-ups itself. Once it has an IP address for a
name, it doesn't look up the name again for the duration of the Java
run-time process.  
  
Fast forward a decade, and the Java run-time is the foundation of many
web sites. It sits there running, and caches DNS lookups as long as the
web site is up.  
  
On my current project, we're changing the IP address of every device we
move, which is typical for a data centre relocation. We have a number of
Java-based platforms, and they're well integrated (read interconnected)
with the rest of our environment, and we're finding we have to take an
outage to restart the Jave-based platforms far too often.  
  
In hindsight, it would have been far simpler to [change the Java
property to disable DNS caching][1]. Run this way for a while in the old
environment to be sure there are no issues (highly unlikely, but better
safe than sorry). Then you can start moving and changing IPs of other
devices knowing your Java-based applications will automatically pick up
the changes you make in DNS.  
  
In case the link above goes stale, the four properties you want to look
at are:  
  
<pre style=\"background-color: white; font-family: &quot;Lucida
Console&quot;, &quot;Courier New&quot;, Courier, monospace; font-size:
12px; line-height: 16px; overflow-x: auto; overflow-y:
auto;\">*networkaddress.cache.ttl*  
*networkaddress.cache.negative.ttl*  
*sun.net.inetaddr.ttl*  
*sun.net.inetaddr.negative.ttl*  
  
</pre>Look them up in your Java documentation and decide which caching
option works best for you. (Normally I'd say how to set the parameters,
but I've never done Java and I fear I'd say something wrong.)



[1]: http://www.rgagnon.com/javadetails/java-0445.html
