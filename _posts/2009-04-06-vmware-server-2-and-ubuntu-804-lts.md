---
layout: post
title: VMware Server 2 and Ubuntu 8.04 LTS
date: '2009-04-06T09:32:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Ubuntu
modified_time: '2009-04-09T17:06:36.981-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4067584872194066454
blogger_orig_url: http://technopragmatica.blogspot.com/2009/04/vmware-server-2-and-ubuntu-804-lts.html
---

Some irritating behaviour that I couldn't resolve pushed me to the big
upgrade of my virtual infrastructure. I was running VMWare Server 1.0.5
on Ubuntu 6.06 on a Dell SC440. Periodically all the VMs would just lock
up for about five minutes. All the VMs would freeze, and even the time
(as reported by date) would fall back by five minutes. The host ran just
fine, and reported that nothing was happening (e.g. top(1) reported 100%
idle).  
  
I was having to endure too many frantic calls from my son that he
couldn't get to lego.com, so it was time to do something.  
  
Some Internet research turned up that I would need VMware Server 1.0.6
at a minimum for Ubuntu 8.04, so that meant I would need to do VMware
first, and therefore go to VMware Server 2.  
  
The upgrade to VMware Server 2 went fairly smoothly, but I had a couple
of problems that sucked far more time than the solution eventually
warranted:  
<ul><li>The management interface didn't work. When I connected to
vmhost:8222 I got the grey VMware background, but it didn't show the
login window. I solved it by some combination of restarting the VMware
management server on the VMware host (sudo /etc/init.d/vmware-mgmt
restart) and clearing the cache in FireFox</li><li>Once the management
interface was up, I couldn't get the console to open on many of my VMs.
The error window told me to look at log files and report the problem.
The VMs were version 4 of the "hardware". I upgraded the VMs' "hardware"
to the current version (7 I think) from the management interface, and
was able to open the console</li><li>When I was installing VMtools, I
was unable to bring the network interfaces back up. I spent much time
trying to figure out what was wrong with VMtools before I realized it
was a simple as my DHCP server had gone away. My DHCP server is in a VM,
but I don't know if anything about the upgrade is what shut down the
DHCP server software</li></ul>The upgrade of Ubuntu went smoothly and
quickly. The big gotcha for me was that I forgot to download the kernel
headers before I rebooted the upgraded server. When I went to rebuild
VMware Server for the new kernel, I couldn't and since my network
depends on VMs, I had to do some manual network configuration to get out
to the Internet and download the kernel headers.  
  
P.S. The reason I decided I should try the upgrade is because the time
handling in Linux kernels is now much more friendly to running in a VM,
whereas the Ubuntu 6.06-era kernel wasn't. I haven't been running long
enough to know if the upgrade has fixed the freezing problem.

