---
layout: post
title: The Cost of Storage
date: '2010-04-02T19:17:00.000-07:00'
author: Larry Reid
tags:
- IT Infrastructure
- SAN
modified_time: '2010-04-11T09:40:54.806-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2455303386439602603
blogger_orig_url: http://technopragmatica.blogspot.com/2010/04/cost-of-storage.html
---

Over the years I've seen SAN storage cost between C$10 and C$20 per GB
(C$ is approximately equal to US$ right now). This is the cost of the
frame, a mix of disks, redundant director-class fibre channel switches
with a number of 48 port cards in each switch, management computer, and
a variety of management and replication software. The cost doesn't
include the HBAs in the servers, or cabling.  
  
The price above is for a very raw GB, before you apply the loss for
whatever classes of RAID you apply.   
  
The management and replication software in all the above cases was the
basic stuff you need to manage a SAN and replicate it. There was no
fancy de-duplication or information lifecycle management going on.  
  
The costs above also didn't include the cost of training dedicated
storage staff to set up and manage a SAN, or the higher salary you'll
have to pay to keep them after you train them.   
  
Compare that to direct attached storage: Right now I can get a 1TB drive
for less than C$300, or about 30 cents per GB. If I put that in a RAID 1
configuration with a RAID controller (less than $400 easily) you would
still be paying less than $1 per GB.  
  
I get RAID 1 storage for an order of magnitude cheaper than raw storage
on a SAN. No need for special management software. You've got rsync for
replication. You can use standard tools that everyone knows how to use. 

  
No wonder Google uses direct-attached storage in commodity servers for
their index. It's just way more cost-effective. What's your business
case for SAN-attached storage?

