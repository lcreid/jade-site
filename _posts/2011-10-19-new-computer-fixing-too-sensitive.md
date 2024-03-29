---
layout: post
title: New Computer -- Fixing the Too-Sensitive Touchpad
date: '2011-10-19T19:52:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- New Computer
modified_time: '2011-10-27T20:37:48.880-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2424568053883776936
blogger_orig_url: http://technopragmatica.blogspot.com/2011/10/new-computer-fixing-too-sensitive.html
---

My new laptop had a way-too-sensitive touchpad. So much so that [I
installed Touchpad Indicator][1] so I could turn it off. Interestingly,
I couldn't use its "turn off touchpad when mouse plugged in" feature,
because it seemed to always think the mouse was plugged in.  
  
That led me to realize that I also didn't have the touchpad tab in the
mouse control panel. Googling, I found that this was a common problem
with ALPS touchpads, like the one I had.  
  
The fix is
here: [https://bugs.launchpad.net/ubuntu/+source/linux/+bug/550625/comments/492][2].
An updated driver that allows you to get at the touchpad control in the
mouse control panel. Download the .deb file, then double-click it and
wait a bit for the Software Centre to run. Click install, enter your
password, wait, then restart, and you'll have the touchpad tab in the
mouse control panel. On the touchpad tab, you can turn off mouse clicks
when typing, and suddenly typing isn't a pain.  
  
I have to resist the urge to rant a bit. I bought an Ubuntu-certified
laptop. This is the sort of pissing around fixing that I was hoping to
avoid. Sigh!



[1]: http://technopragmatica.blogspot.com/2011/10/new-computer-touchpad-too-sensitive.html
[2]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/550625/comments/492
