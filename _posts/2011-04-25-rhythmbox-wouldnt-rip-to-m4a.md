---
layout: post
title: Rhythmbox Wouldn't Rip to .m4a
date: '2011-04-25T07:41:00.000-07:00'
author: Larry Reid
tags:
- music
- Ubuntu
modified_time: '2011-04-25T07:41:25.201-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8864214101232286963
blogger_orig_url: http://technopragmatica.blogspot.com/2011/04/rhythmbox-wouldnt-rip-to-m4a.html
---

I had a problem yesterday where Rhythmbox wouldn't rip a CD to .m4a
format. I went to the Preferences window to set the format, and it
wouldn't appear in the drop-down. Curiously, if I clicked the Add button
it would show the existing formats, and .m4a was in that list.   
  
After much flailing, I discovered that you need to have both
gstreamer0.10-plugins-bad and gstreamer0.10-plugins-bad-multiverse
installed. I had removed the multiverse one a few weeks ago when I
thought I was cleaning up after a previous round of flailing to get
something around music working.

