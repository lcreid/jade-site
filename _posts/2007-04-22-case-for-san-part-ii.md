---
layout: post
title: The Case for SAN Part II
date: '2007-04-22T07:38:00.000-07:00'
author: Larry Reid
tags:
- Disk Array
- SAN
modified_time: '2007-05-11T09:43:24.838-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-545326228789996469
blogger_orig_url: http://technopragmatica.blogspot.com/2007/04/case-for-san-part-ii.html
---

When I did a total cost of ownership calculation for SAN-attached disk
arrays during a recent assignment, the biggest factor in favour of SAN
was the usage factor. With direct-attached disk on servers, you
typically over-allocate the disk by a wide margin, because adding disk
at a later time is a pain. With SAN-attached storage you can pop some
more disks into the disk array and, depending on the operating system,
you can increase the storage available in a relatively easy way.  
  
Therefore if you manage your SAN-attached storage on a just-in-time
basis, you can achieve perhaps 80 percent utilization of the disk,
whereas in a typical group of servers using direct attached storage you
might have 20 percent utilization. This four-t0-one price difference is
significant.  
  
[Earlier][1] I calculated that there's roughly a ten to one difference
between consumer disk and the top-of-the-line SAN disk in at least one
manufacturer's offerings. So a four-to-one price difference goes some
way to fixing that, but not all the way. And to chip away further at the
disk usage argument, a lot of the disks that contribute to the 20
percent utilization number are the system disks on small servers. These
days you can't get much less the 72 GB on a system disk, and most
servers need far, far less than that. My technical experts recommend
that you don't boot from SAN, so you'll still have that low utilization
rate even after installing a SAN.  
  
I'm not making much of a case for SAN, am I?



[1]: http://technopragmatica.blogspot.com/2007/04/case-for-san-part-i.html
