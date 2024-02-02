---
layout: post
title: Ubuntu Breaks Thinkpad Yet Again
date: '2009-09-20T17:10:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2009-09-20T17:19:51.476-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1986493192606023453
blogger_orig_url: http://technopragmatica.blogspot.com/2009/09/ubuntu-breaks-thinkpad-yet-again.html
---

Sometime in the last couple of weeks the brightness controls on my
Thinkpad x300 stopped working.  
  
I fixed it by creating /etc/modprobe.d/thinkpad\_acpi.conf and putting
this line in it:  
<pre>options thinkpad\_acpi hotkey=enable,0xfdffff</pre>Then you have to
remove and reinstall the module to read the new options:<pre>sudo rmmod
thinkpad\_acpi  
sudo modprobe thinkpad\_acpi</pre>I'm not sure I'm getting all the
brightness I should, but at least the control works to put the
brightness up to make the screen readable.  
  
Whine: This isn't the first time some part of the interface between
Ubuntu and my laptop has broken due to an update. I can sympathize with
the developers and the difficulty of testing all laptops out there, but
I can sympathize more with the user who isn't going to put up with an
O/S that mysteriously starts and stops working as updates are installed.

