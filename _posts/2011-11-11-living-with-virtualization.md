---
layout: post
title: Living with Virtualization
date: '2011-11-11T07:14:00.001-08:00'
author: Larry Reid
tags:
- VMWare
- VirtualBox
- Virtualization
- IT Infrastructure
modified_time: '2011-11-11T08:02:26.436-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8311992956978591096
blogger_orig_url: http://technopragmatica.blogspot.com/2011/11/living-with-virtualization.html
---

In 2006, I was project manager on a VMware implementation for a health
care organization. We virtualized 200 servers in six weeks, after a
planning phase of about 2 months. Out of that experience I wondered,
"Did virtualization have anything to offer a smaller business?" So I set
up a box at home and converted my home "data centre" into a virtualized
data centre using VMware's Server product, which was the free product at
the time.  
  
After five years it's been an interesting experience and I've learned a
lot. At the end of the day, I'm pretty convinced that the small business
that has a few servers running in a closet in their office doesn't have
a lot to gain from virtualizing within the "closet". (I'm still a big
fan of virtualization in a medium or large organization.) I'm going to
switch back to running a single server with all the basic services I run
(backup, file share, DNS, DHCP, NTP) on a single server image.  
  
I had one experience where the VM approach benefited me: As newer
desktops and laptops came into the house, the version of the backup
client installed on them by default was newer than the backup master on
my backup server (I use [Bacula][1]{: target="_blank"}). Rather than
play around with installing and updating different versions of the
backup client or master, I simply upgraded the backup master VM to a new
version of Ubuntu and got the newer version of Bacula. I didn't have to
worry about what other parts of my infrastructure I was going to affect
by doing the upgrade.  
  
The down side was that I spent a lot of time fooling around with VMware
to make it work. Most kernel upgrades require a recompile of the VMware
tools on each VM, which was a pain. I spent a fair bit of time working
through an issue about timekeeping on the guests versus the VMware host
that periodically caused my VMs to slow to a crawl.  
  
Connecting to the web management interface and console plug-in always
seemed to be a bit of a black art, and it got worse over time. At the
moment, I still don't think modern versions of FireFox can connect to a
running VM's console, so I have to keep an old version around when I
need to do something with a VM's console (before ssh comes up).  
  
My set-up wasn't very robust in the face of power failures. When the
power went off, the VMs would leave their lock files behind. Then, when
the power came back, the physical machine would restart but the VMs
wouldn't. I would have to go in by hand and clean up the lock files. And
often I wouldn't even know there'd been a power failure, so I'd waste a
bit of time trying to figure out what was wrong. I should have had a
UPS, but that wouldn't solve all the instances where something would
crash leaving a lock file behind.  
  
All in all, and even if I had automated some of that, the extra level of
complexity didn't buy me anything. In fact, it cost me a lot of time.  
  
Some of these problems would have been solved by using the ESX family of
VMware products, but the license fees guarantee that the economics don't
work for a small business.  
  
I originally started out planning to give [Xen][2]{: target="_blank"} a
try, but it turned out not to work with the current (at the time)
version of Ubuntu. Today I would try [KVM][3]{: target="_blank"}. I
played around with it a bit last year and it looked fine for a server VM
platform. I needed better USB support, so I switched to
[VirtualBox][4]{: target="_blank"}. VirtualBox worked fine for me to run
the Windows XP VM I used to need to run my accounting program, but it
has the free version/enterprise version split that makes me
uncomfortable for business use.  
  
So my next home IT project will be to move everything back to a simpler,
non-virtualized platform. I'll still keep virtualization around for my
sandbox. It's been great to be able to spin up a VM to run, say, an
instance of [Drupal][5]{: target="_blank"} to test upgrades before
rolling out to my web site, for example, or to try out [Wordpress][6]{:
target="_blank"}, or anything else I need to try.  
  
My blog posts about interesting steps along the virtualization road are
[here][7].



[1]: http://www.bacula.org/
[2]: http://xen.org/
[3]: http://www.linux-kvm.org/page/Main_Page
[4]: https://www.virtualbox.org/
[5]: http://drupal.org/
[6]: http://wordpress.org/
[7]: http://technopragmatica.blogspot.com/search/label/Virtualization
