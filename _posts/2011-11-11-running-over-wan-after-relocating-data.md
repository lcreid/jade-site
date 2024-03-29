---
layout: post
title: Running Over the WAN After Relocating a Data Centre
date: '2011-11-11T08:06:00.001-08:00'
author: Larry Reid
tags:
- Relocation
- IT Infrastructure
modified_time: '2011-11-11T08:35:11.162-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2277325627722174870
blogger_orig_url: http://technopragmatica.blogspot.com/2011/11/running-over-wan-after-relocating-data.html
---

My current data centre relocation has us moving the data centre about
400 kms away from its current location. This has resulted in a total
round-trip change in latency of 6 ms. We implemented WAN acceleration in
certain locations to address the issue, and we've learned some lessons
in the process. Lessons learned is what this post is about.  
  
We have offices all over the province, so not everyone sees the 6 ms
change in latency as a negative. Many users are now closer to the data
centre than they were before, and we always had users who had worse than
6 ms latency to our data centre. That gave us a lot of confidence that
everything would be fine after the relocation.  
  
However, the old data centre location was the head office, so a large
number of users are now experiencing latency where they never did
before, including senior management. Most of the remote sites were much
smaller than head office.   
  
The one or two issues we've had up to recently were due to our phased
approach to moving. In one case we had to move a shared database server
without moving all the application servers that used it. After the move,
we had to do a quick move of one application server, because we
discovered it just couldn't live far from its database server.  
  
That changed recently. Like many organizations, we have shared folders
on Windows file shares. Windows file shares are generally considered a
performance risk for data centre relocations when latency changes. In
preparation, we implemented WAN acceleration technology.  
  
We moved the main file share, and by about 10 AM we were experiencing
lots of calls to the help desk about slow performance. After a hour or
two of measuring and testing, we decided to turn off WAN acceleration to
improve the performance. Indeed, the calls to help desk stopped after
turning off the WAN acceleration.  
  
Analysis showed that the Windows file share was using SMB signing. SMB
signing not only prevents the WAN accelerator from doing its job, but
the number of log messages being written by the WAN accelerator may have
actually been degrading performance to worse than an un-accelerated
state.  
  
So we turned off SMB signing, and tried again a few days later. No luck.
Around 9:30 AM we started to get lots of calls, and again we turned off
the WAN acceleration. We're lucky that performance is acceptable even
without WAN acceleration (for the time being -- we'll need it soon).  
  
We're still working this issue, so I don't know what the final solution
is. I'll update this post when I know.  
  
A non-technical lesson learned: If I were to implement WAN acceleration
again, I'd get all the silos in a room in the planning stages, before I
even bought anything. I'd make the network people, Windows
administrators, and storage administrators understand each others'
issues. I would have the WAN accelerator vendor and the storage device
vendor at the table as well. And I'd make everyone research the topic
using Google so we could find out what issues other people ran into.  
  
Oh, and one final lesson learned: Bandwidth hasn't been an issue at all.
In this day and age, 1 Gbps WAN connections are within the reach of a
medium-sized organization's budget. We're finding 1 Gbps is more than
enough bandwidth, even with the large data replication demands of the
our project. And those demands will go away once the data centre is
fully relocated.

