---
layout: post
title: A New Computer -- Installing VirtualBox
date: '2011-10-02T14:16:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- New Computer
modified_time: '2011-10-03T06:18:16.236-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1246972361504058756
blogger_orig_url: http://technopragmatica.blogspot.com/2011/10/new-computer-installing-virtualbox.html
---

I installed VirtualBox from the Ubuntu Software Centre on my new
computer. I had already copied over my VM -- it came with all the other
files when I copied everything under /home.  
  
When I figured out how to run VirtualBox under Unity (it's under
Accessories), it came up and knew about all the VMs I had on the old
machine. When I started my Windows VM, it complained that it couldn't
find "/usr/share/virtualbox/VBoxGuestAdditions.iso". Sure enough, the
iso wasn't anywhere on the new machine.  
  
However, for my purposes I didn't need the iso. I just unloaded the iso
from the virtual CD device for the virtual machine, and tried
restarting. It worked.  
  
I would need the guest additions iso sometime, so, with the virtual
machine running, I went to the Devices-&gt; Install Guest Additions
menu. It asked me if I wanted to download the file from the Internet,
and I said "yes".

