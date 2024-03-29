---
layout: post
title: Virtualization So Far
date: '2008-03-23T20:28:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Virtualization
- Ubuntu
- IT Infrastructure
- Xen
modified_time: '2008-03-24T21:16:51.066-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1247549582327834446
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/virtualization-so-far.html
---

As should be obvious from my recent posts, I've been trying to set up a
host for virtual machines. I need to be able to try things out easily,
and virtual machines are great for that. I'd also like to get rid of my
old boxes that are running core network infrastructure. It's not so much
that I want to get rid of them, but the risk of continuing to use them
is a problem. I have an 11-year-old Macintosh Performa that's my DHCP
and DNS server for my whole network. If it breaks, I'm scrambling to
replace it unless I get something new built. Obviously if it runs on a
computer with a 1 GB hard drive and 32 MB of memory, I should be able to
run it on a VM.  
  
Anyway, being cheap I wasn't sure I wanted to pay for VMWare. They have
a free version of course, but XenSource's free version is a license-key
upgrade, whereas VMWare Server to Virtual Infrastructure (AKA ESX) is a
complete software upgrade. So I thought I'd try XenSource, especially
since they seemed to be saying that they could run any OS if you bought
a CPU with virtualization support.  
  
So I carefully researched the chips I was looking for and bought a Dell
SC440 with an Intel Xeon 3050. A low-price server but with the right
parts, or so I thought.  
  
The install of XenSource was easy, as was the install of XenCenter, the
control program on Windows. Unfortunately, there was a problem with the
shortcut to install XenCenter. I posted a question in the Xen community
boards and got no help. I found the solution myself a few days later,
but not after noticing that there was very, very little activity on the
community boards. I wonder if anyone is using Xen, or at least is anyone
using it without paying Citrix for support?  
  
Also, it turns out you can't run anything you want as a VM. I tried to
run Ubuntu Server 6.06.1 and it gets disk errors. This is a known
problem, apparently. Okay, I know it's hard to support every Linux
distro, but Ubuntu should be one you support. Look at the numbers.  
  
Anyway, worse than not supporting Ubuntu is that the answer from Citrix
seemed to be, "use one of our supported distros." They'll always be
niche if that's their approach. The market for virtualization is the
world of heterogenous data centres that need to shrink their power and
A/C footprint. You're not going to get into that market unless you can
run anything that an off-the-shelf PC can run. So, I decided to try
VMWare.  
  
Installing a 60-day evaluation copy of ESX 3i didn't work. Neither did
installing an evaluation copy of ESX 3.5, but at least it told me that
the network card wasn't supported. So I tried Ubuntu 6.06.1, and the
network card wasn't supported there, either. Broadcom, what are you
doing releasing a NIC that doesn't work with older drivers? [I found how
to get Ubuntu installed][1], and so I'll continue with installing the
free version of VMWare Server. This is not what I wanted to be doing.  
  
I guess the lesson is you really have to check the hardware
compatibility list, but I didn't even know I was going to go this path.
I'm interested in how many other problems I'm going to have.  
  
Even though I'm not up with VMWare Server, I have to say that it's the
preferable approach. At least you have an underlying OS you can work
with, and my experience with VMWare elsewhere says it's going to run
whatever I try to put on it. Too bad the thinner versions (ESX) don't
work on my hardware.



[1]: http://technopragmatica.blogspot.com/2008/03/ubuntu-6061-on-dell-sc440.html
