---
layout: post
title: Ubuntu VMs and Time
date: '2009-05-14T07:38:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Ubuntu
- Bacula
modified_time: '2009-05-28T07:35:34.304-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-909336737573899114
blogger_orig_url: http://technopragmatica.blogspot.com/2009/05/ubuntu-vms-and-time.html
---

Ubuntu 8.04 in VMs under VMWare Server 2.0.1 need the kernel parameter
"clocksource=acpi\_pm" when they boot. Edit /boot/grub/menu.lst and add
"clocksource=acpi\_pm" to the end of the line that starts "# kopt=".
Don't remove the "#". In this context it's not a comment. After you save
the file, run "sudo update-grub" and then reboot.  
  
If the guest doesn't have this kernel parameter specified, time runs
backwards on the guest O/S, or time hangs or gets stuck. This was
showing up especially on my backup server running bacula, and the backup
clients that had large amounts of data. I suspect that high loads
exacerbate the problem.

