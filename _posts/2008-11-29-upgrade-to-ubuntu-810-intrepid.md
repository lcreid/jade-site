---
layout: post
title: Upgrade to Ubuntu 8.10 Intrepid
date: '2008-11-29T16:22:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
- Lenovo x300
modified_time: '2008-12-01T06:24:43.070-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2605257373841554802
blogger_orig_url: http://technopragmatica.blogspot.com/2008/11/upgrade-to-ubuntu-810-intrepid.html
---

| I upgraded my laptop (<span class="blsp-spelling-error" id="SPELLING_ERROR_0">Lenovo</span> x300) to <span class="blsp-spelling-error" id="SPELLING_ERROR_1">Ubuntu</span> 8.10 a few weeks ago. The rumour was that power management was better, and I was longing for a kernel that handled the sound on the x300 without a re-compile of the driver every time I updated the kernel.  
  
The upgrade went smoothly, although it took a very long time. The default <span class="blsp-spelling-error" id="SPELLING_ERROR_2">Ubuntu</span> mirror for Canada seems to be very slow these days. (I've since switched to<span style="font-family:courier new;"> http://gpl.savoirfairelinux.net/pub/mirrors/ubuntu</span>. It seems a lot faster.)  
  
Two things I've had to work on. First, suspend and resume screws up the wireless until you add a line to <span style="font-family:courier new;">/etc/pm/config.d/00sleep\_module</span>. First, you have to figure out which driver you're using for wireless. Do  
<blockquote style=\"font-family: courier new;\"><span class="blsp-spelling-error" id="SPELLING_ERROR_3">lshw</span> | more  
</blockquote>Look for the line that says "wireless" by typing "/wireless" to the more prompt. Then look for the next line with "driver" in it. In my case it says "driver=<span class="blsp-spelling-error" id="SPELLING_ERROR_4">iwlagn</span>". So now edit the file and add the required line:  
<blockquote style=\"font-family: courier new;\"><span class="blsp-spelling-error" id="SPELLING_ERROR_5">sudo</span> <span class="blsp-spelling-error" id="SPELLING_ERROR_6">gedit</span> /etc/pm/config.d/00sleep\_module  
</blockquote>Add the following at the very end:  
<blockquote style=\"font-family: courier new;\">SUSPEND\_MODULES="<span class="blsp-spelling-error" id="SPELLING_ERROR_7">iwlagn</span>"  
</blockquote>The other problem was more mysterious. CBC Radio's website wouldn't play after upgrading to 8.10. It had worked for my in 8.04 after some fooling around, but I couldn't get it to work. I had given up after wasting almost a whole day on the problem. After a few software upgrades, it started to work. For the record, I'm using gnome-<span class="blsp-spelling-error" id="SPELLING_ERROR_8">mplayer</span> to play Windows Media Player material. |

