---
layout: post
title: Installing Ubuntu on Xen
date: '2008-03-17T21:12:00.000-07:00'
author: Larry Reid
tags:
- Virtualization
- IT Infrastructure
- Xen
modified_time: '2008-03-17T21:15:29.846-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4696012756839853994
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/installing-ubuntu-on-xen.html
---

I was able to install Ubuntu 6.06.1 on Xen by putting the Ubuntu install
CD in the CD drive of the Xen server. I got lost for a while because I
didn't create the storage when initially setting up the VM. Once I
actually made a disk, the install went okay. I've found a post saying
that [Ubuntu will start having errors and switch the disk to
read-only][1], so I'll watch for that.  
  
I still need to install the Xen tools...



[1]: http://forums.xensource.com/message.jspa?messageID=10310
