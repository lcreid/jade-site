---
layout: post
title: The Case for SAN Part I
date: '2007-04-11T07:24:00.000-07:00'
author: Larry Reid
tags:
- Disk Array
- SAN
modified_time: '2007-05-11T09:44:58.414-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4267068086740109994
blogger_orig_url: http://technopragmatica.blogspot.com/2007/04/case-for-san-part-i.html
---

One pays more than ten times as much for storage on a big SAN-attached
disk array than one does for direct attached storage (DAS). A raw
terabyte of disk to put in a desktop computer casts about C$400. Storage
on a SAN-attached mid-range disk array from one manufacturer costs about
C$17,000 per raw TB. Storage on another manufacturer's low-end disk
array costs about C$7,000 per raw TB. (Those are prices for health care,
so a business could expect to pay a fair bit more.) And for SAN-attached
storage you also have to pay for the SAN network itself, which can cost
about C$3,500 per port for quality equipment.  
  
Of course, you don't buy a big, SAN-attached disk array for reduced cost
per TB. You buy it for some combination of:  
<ul><li>lower total cost of ownership  
</li><li>reliability</li><li>availability</li><li>manageability</li><li>performance</li><li>the
brute capacity to store multiple terabytes.  
</li></ul>However, $10 to $1 is an awfully steep premium to pay for
those advantages. Before you make that significant investment, you need
to evaluate whether you really need those advantages, and in some cases
whether you're really going to realize the benefits.  
  
A few examples will show what I mean.  
  
How about availability? I'm aware of a disk array manufacturer that
doesn't support a hot firmware upgrade for one series of disk arrays
(they say you can do it, but you have to sign a waiver for any data loss
during the upgrade). The upgrade itself takes very little time, but you
still need to shut down all the servers that connect to that disk array,
and then start them up and test them after the upgrade. If you have
fifty servers connected to the disk array, you're looking at an hour or
more to shut them all down, and typically more than that to start them
all up again. Suddenly your uptime numbers don't look so good anymore.
And heaven help you if the users of those fifty servers have different
preferred downtime windows, as was the case in my experience.  
  
Reliability? In one year, in a population of four disk arrays of the
same model, there were three significant unplanned downtimes, including
one with significant data loss. (The data was eventually recovered from
backup.) From sources inside the manufacturer of that disk array, I've
heard that they've had a data loss event in almost one percent of their
installations.  
  
In a population of two disk arrays from another manufacturer, one
required periodic reboots from the day it was turned on until the
firmware was upgraded. Why did one work fine and the other not, in
similar although not identical environments? The reality is, disk arrays
are big, complicated pieces of IT and there's ample opportunity for
software defects to manifest themselves in production use.  
  
So far I'm not making much of a case for SAN-attached storage. I believe
that one challenge with SAN is that it's sold as the solution to all
problems, when in reality it has the potential to create two new
problems for every one it solves. I think SAN-attached storage has its
place, and in many cases it's the only technology that can do what we
need. In follow-up posts I hope to give some guidelines that I think
would help you realize the benefits of SAN and to avoid the pitfalls.  
  
As always, I'd like to hear from you about your experience. Please leave
a comment on this blog.

