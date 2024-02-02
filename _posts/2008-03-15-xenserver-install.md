---
layout: post
title: XenServer Install
date: '2008-03-15T07:35:00.000-07:00'
author: Larry Reid
tags:
- Virtualization
- IT Infrastructure
- Xen
modified_time: '2008-03-15T08:10:55.479-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8561862764754467360
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/xenserver-install.html
---

I bought a Dell SC440 for [Jade Systems][1] (that's me). I'm setting it
up as a virtual host so I can create virtual computers at will. I've
decided to try [XenServer][2], I think mostly because the [free
version][3] is just a license-key upgrade to the full version. Besides,
I already have some experience with VMWare, albeit second hand.  
  
I had to F2 into the BIOS on initial boot of the SC440 to turn on
virtualization in the CPU. It was relatively easy to find on the menus,
but not right at the top level (My apologies for the vagueness here. The
servers are in another room, so I wasn't blogging while I was
installing).  
  
The install of XenServer 4.0.1 went exactly according to the
instructions. I read through the four pages of documentation first, and
so I had all the answers I needed -- the usual network set-up, which
time servers to use, etc.  
  
I just finished [installing the security patch][4]. First challenge:
actually getting the file to the XenServer host. I put a DVD in the DVD
drive, but there's no entry for CD or DVD in <span style="font-family:
courier new;">/etc/fstab</span>. The installation instructions recommend
using a USB key. I flailed on that for a while, Googling for
Linux-for-dummies level help on USB, before I said to myself, "Right. I
guess I still have to be a Linux sysadmin," and found the appropriate
dev to mount the dvd. From there it was maybe a minute to install the
patch.  
  
Total time: About half an hour to install XenServer the other night,
mostly unattended after the usual initial Linux questions, plus 45
minutes now, mostly Googling.



[1]: http://www.jadesystems.ca
[2]: http://www.citrixxenserver.com/Pages/default.aspx
[3]: http://www.xensource.com/products/Pages/XenExpress.aspx
[4]: http://www.xensource.com/Pages/Download_4.0.1_Hotfix-2007-001.aspx
