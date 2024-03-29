---
layout: post
title: A New Computer -- Printing
date: '2011-10-14T18:15:00.000-07:00'
author: Larry Reid
tags:
- Printer
- Ubuntu
- New Computer
modified_time: '2011-10-14T18:15:46.126-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7215117785153281832
blogger_orig_url: http://technopragmatica.blogspot.com/2011/10/new-computer-printing.html
---

Setting up my multi-function printer on Ubuntu has always been
interesting. When I first got my printer, it was so new I had to
download and build hplip, the printing subsystem.  
  
It looks like installation is a lot easier now, but to get started you
still have to go into a terminal and type:  
  
`hp-setup`  
  
That starts a GUI that easily discovered my printer on the network.
Unfortunately, when I tried to install the driver, it failed with "<span
class="Apple-style-span" style="font-weight: 600;">The download of the
digital signature file failed." That sucks. But wait! The server that
holds the drivers is actually run by the Linux Foundation, and it was
off the air because of the security breach almost a month ago.</span>  
<span class="Apple-style-span" style="font-weight: 600;">  
</span>  
<span class="Apple-style-span" style="font-weight: 600;">Finally, about
a week and a half later, hp-setup worked. It now brings up a GUI window
and walks you through a few steps: You have to tell it whether you
printer is USB, parallel or network-connected. It's not much closer to
being, "It just works."</span>

