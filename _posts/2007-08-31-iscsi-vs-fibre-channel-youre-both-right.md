---
layout: post
title: iSCSI vs. Fibre Channel - You're Both Right
date: '2007-08-31T07:27:00.000-07:00'
author: Larry Reid
tags:
- Backups
- Virtualization
- IT Infrastructure
- SAN
modified_time: '2008-01-05T08:28:01.477-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6786166263658226480
blogger_orig_url: http://technopragmatica.blogspot.com/2007/08/iscsi-vs-fibre-channel-youre-both-right.html
---

Reading another [article][1] from an expert who provides less than
useful information has finally prompted me to try to provide useful
guidance for IT managers of 50 to 1,000 diverse servers running a
variety of applications.  
  
[<span class="blsp-spelling-error"
id="SPELLING_ERROR_0">iSCSI</span>][2] vs. [fibre channel][3] (<span
class="blsp-spelling-error" id="SPELLING_ERROR_1">FC</span>) is a
classic technology debate with two camps bombarding each other
mercilessly with claims that one or the other is right. The reason the
debate is so heated and long lived is because there isn't a right
answer: there are different situations in which each one is better than
the other. Here's how to figure out what's best for you:  
  
Start with the assumption that you'll use <span
class="blsp-spelling-error" id="SPELLING_ERROR_2">iSCSI</span>. It's
less expensive, so if it does what you need, it should be your choice.
It's less expensive at all levels: The switches and cables enjoy the
<span class="blsp-spelling-error" id="SPELLING_ERROR_3">ecnomy</span> of
scale of the massive market for <span class="blsp-spelling-error"
id="SPELLING_ERROR_4">IP</span> networking. You already have staff who
know how to manage <span class="blsp-spelling-error"
id="SPELLING_ERROR_5">IP</span> networks. You already have a stock of
Cat 6 cables hanging in your server rooms or network closets.  
  
If you have mostly commodity servers, they transfer data to and from
direct-attached storage at less than <span class="blsp-spelling-error"
id="SPELLING_ERROR_6">gigabit</span> speeds. <span
class="blsp-spelling-error" id="SPELLING_ERROR_7">Gigabit</span> <span
class="blsp-spelling-error" id="SPELLING_ERROR_8">iSCSI</span> is fine.
If you have a lot of servers, you have to size the switches correctly,
but you have to do that with <span class="blsp-spelling-error"
id="SPELLING_ERROR_9">FC</span> as well, and the <span
class="blsp-spelling-error" id="SPELLING_ERROR_10">FC</span> switch will
be more expensive. Implement jumbo frames so backups go quickly.  
  
Just because you're using <span class="blsp-spelling-error"
id="SPELLING_ERROR_11">iSCSI</span> doesn't mean you're running your
storage network over the same cables and switches as your data centre
LAN. In fact, you probably aren't. The cost saving doesn't come from
sharing the existing LAN, it comes from the lower cost per port and the
reduced people cost (skill sets, training, availability of
administrators in the labour market) of using the same technology. As
long as your storage and general-purpose networks are not sharing the
same physical network, a lot of the criticisms of <span
class="blsp-spelling-error" id="SPELLING_ERROR_12">iSCSI</span>
evaporate.  
  
If you have large, specialized servers that can and do need to sustain
high data transfer rates, then definitely look at <span
class="blsp-spelling-error" id="SPELLING_ERROR_13">FC</span>. Be sure
you're measuring (not just guessing) that you need the data transfer
rates.  
  
If you have a large farm of physical servers running a huge number of
virtual machines (<span class="blsp-spelling-error"
id="SPELLING_ERROR_14">VMs</span>), look at <span
class="blsp-spelling-error" id="SPELLING_ERROR_15">FC</span>. My
experience is that virtual machine infrastructures tend to be limited by
RAM on the physical servers, but your environment may be different. You
may especially want to think about how you [back up your <span
class="blsp-spelling-error" id="SPELLING_ERROR_16">VMs</span>][4]. You
may not need the <span class="blsp-spelling-error"
id="SPELLING_ERROR_17">FC</span> performance during the day, but when
backups start, watch out. It's often the only time of day when your IT
infrastructure actually breaks a sweat.  
  
You might look at a <span class="blsp-spelling-error"
id="SPELLING_ERROR_18">FC</span> network between your backup media
servers and backup devices, especially if you already have an <span
class="blsp-spelling-error" id="SPELLING_ERROR_19">FC</span> network for
one of the reasons above.  
  
Yes, <span class="blsp-spelling-error" id="SPELLING_ERROR_20">FC</span>
will give you higher data transfer rates, but only if your servers and
storage devices can handle it, and few today go much beyond one <span
class="blsp-spelling-error" id="SPELLING_ERROR_21">gigabit</span>. <span
class="blsp-spelling-error" id="SPELLING_ERROR_22">FC</span> will
guarantee low latency so your servers won't do their equivalent of
"Device not ready, Abort, Retry, Ignore?"  
  
The challenge for an IT manager, even (or especially) those like me who
have a strong technical background, is that it's easy to get talked into
spending too much money because you <span style="font-style:
italic;">might </span>need the performance or low latency. The problem
with that thinking is that you spend too much money on your storage
network, and you don't have the money left over to, for example, mirror
your storage, which may be far more valuable to your business.  
  
A final warning: neither technology is as easy to deal with as the
vendor would have you believe (no really?). Both will give you headaches
for some reason along the way. If it wasn't hard, we wouldn't get the
big bucks, would we?



[1]: http://www.eweek.com/article2/0,1759,2172315,00.asp?kc=EWRSS03129TX1K0000606
[2]: http://en.wikipedia.org/wiki/Iscsi
[3]: http://en.wikipedia.org/wiki/Fibre_channel
[4]: http://technopragmatica.blogspot.com/2007/04/virtualization-theres-gotta-be-catch.html
