---
layout: post
title: Keyboard Layouts Disappear when Plugging In Keyboard
date: '2009-06-25T07:37:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2009-08-06T13:59:39.059-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2442065391338559443
blogger_orig_url: http://technopragmatica.blogspot.com/2009/06/keyboard-layouts-disappear-when.html
---

I have USA and Spanish (Spain) keyboard layouts defined on my laptop,
with USA being the default. When I plug in my external keyboard I can no
longer choose the Spanish layout either from the keyboard layout
indicator in the panel or via the keyboard shortcut I\'ve defined. If I
bring up the keyboard preferences, the Spanish keyboard is still in the
list. To work around the problem, I either delete it and re-add the
Spanish layout, or restart Gnome (log out and log in).

Sometimes after unplugging and plugging in the keyboard, attempting to
switch layouts will cause the keyboard indicator to display \"??\"
instead of \"USA\" or \"Esp\". Sometimes it simply displays \"USA\". In
either case, the keyboard responds with the USA layout, meaning no easy
access to the Spanish characters.

I\'m running on a Lenovo Thinkpad x300. The original Ubuntu install was
8.04 and I\'ve upgraded (using the upgrade process via Synaptic, not by
reinstalling) to 8.10 and now 9.04. I have an external PS/2 keyboard in
Spanish/Spain physical layout that I plug in to the laptop through a
PS/2 to USB cable. The laptop has a USA physical layout.

I first noticed this with 8.10, but I can\'t say for sure that it
wasn\'t a problem in 8.04 as I didn\'t use the external keyboard very
much with 8.04. On 8.10, the problem also happened when I suspended and
resumed, but that seems to be fixed in 9.04. I can suspend and resume
and the Spanish layout is still available. However, if I actually unplug
the external keyboard and plug it back in, I lose the Spanish layout.

UPDATE: There is a fix: Add the jaunty-proposed packages to your package
source list. Through the GUI that\'s System-> Administration-> Software
Sources. Then run System-> Administration-> Update Manager.

Here\'s the original fix:

1.  Read about updating from PPAs here: [https:/<wbr />
    
    /help.launchpad<wbr />
    
    .net/Packaging/<wbr />
    
    PPA#Installing%<wbr />
    
    20software%<wbr />
    
    20from%<wbr />
    
    20a%20PPA][1]{: rel="nofollow"}
2.  Add Sergey\'s PPA to your apt sources: [https:/<wbr />
    
    /launchpad.<wbr />
    
    net/~sergey-<wbr />
    
    udaltsov/<wbr />
    
    +archive/<wbr />
    
    ppa][2]{: rel="nofollow"}
3.  Update your software, making sure that one of the packages updated
    is \"libxklavier - 3.9-0ubuntu3\"
4.  Restart your computer

This is Ubuntu bug [#363169][3].  
  
I spent a lot of time flailing around the Internet looking for a
solution to this problem. I posted my problem to Ubuntu's Launchpad in
mid-May and no one appears to have even looked at it except me. In the
meantime, bug #363169 was posted in mid-April, and all my searches
hadn't turned it up. Only when I posted the bug to Gnome (thinking it
was a Gnome problem, not Ubuntu), did [Sergey][4] helpfully see it and
point it back over to the correct Ubuntu bug, with a fix.  
  
I've tried to update a few places in Launchpad where I was looking for
solutions, but I fear that others having this same problem won't see it.
That's why I've made this blog post.



[1]: https://help.launchpad.net/Packaging/PPA#Installing%20software%20from%20a%20PPA
[2]: https://launchpad.net/%7Esergey-udaltsov/+archive/ppa
[3]: https://bugs.launchpad.net/ubuntu/+source/libxklavier/+bug/363169
[4]: https://launchpad.net/%7Esergey-udaltsov
