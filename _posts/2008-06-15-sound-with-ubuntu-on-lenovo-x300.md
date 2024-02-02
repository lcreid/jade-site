---
layout: post
title: Sound with Ubuntu on Lenovo x300
date: '2008-06-15T07:05:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- Lenovo x300
modified_time: '2008-06-15T07:25:21.642-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2340845020538510700
blogger_orig_url: http://technopragmatica.blogspot.com/2008/06/sound-with-ubuntu-on-lenovo-x300.html
---

One of the known issues with Ubuntu on a Lenovo x300 is the sound (up to
and including Ubuntu 8.04). There are a few links out there that point
to solutions. The one that worked for me is [this one in Mikko's
Blog][1]. One very important note: Check which version of the kernel
you're running before you start.  
<blockquote>uname --release</blockquote>Then substitute your kernel
version in the rm command. I also got a bit confused by the statement
under the "Sound" heading that said to remove the old sound modules. I
eventually figured out that he must have been referring to the rm
command in his script, rather than actually removing the running
modules.  
  
FYI: My rather short list of Ubuntu and Lenovo x300 links is [here][2]. 

  
  
<blockquote></blockquote><blockquote></blockquote>



[1]: http://koo.fi/tech/2008/06/05/lenovo-thinkpad-x300-ubuntu-804-installation-notes/
[2]: http://del.icio.us/lcreid/lenovox300
