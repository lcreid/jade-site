---
layout: post
title: Managing Music on an SD Card for Nintendo DS
date: '2010-12-19T16:09:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2010-12-19T16:09:37.280-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-415083421121034332
blogger_orig_url: http://technopragmatica.blogspot.com/2010/12/managing-music-on-sd-card-for-nintendo.html
---

I wanted to manage music on an SD card, as that's the way a Nintendo DS
gets its music. I wanted my son to have his music on his DS so he didn't
have to keep track of and charge an MP3 player and a DS.  
  
First, Rhythmbox on Ubuntu 10.04 wouldn't recognize the SD card.
Fortunately, I'd stumbled across the solution to that a few weeks ago:
put a file called ".is\_audio\_player" in the root of the SD card.  
  
However, it still wouldn't copy m4a files over. The DS only plays m4a
files, not mp3. I discovered that you can actually put content in the
.is\_audio\_player file to control the behaviour of Rhythmbox. It was
still hard to figure out what to put in, but finally I looked up what
Rhythmbox uses to manage an iPod, and put this in the .is\_audio\_player
file:  
  
<pre><span class="Apple-style-span" style="font-family: 'Courier New',
Courier, monospace;">folder\_depth=99  
output\_formats=audio/mpeg,audio/aac,audio/x-wav,audio/x-aiff</span></pre>

Worked a charm after that.  
  
P.S. My son's doing some serious scratch with the Police on his DS right
now.

