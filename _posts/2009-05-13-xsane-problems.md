---
layout: post
title: xsane Problems
date: '2009-05-13T16:07:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2009-05-13T16:25:50.462-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6210052553523191848
blogger_orig_url: http://technopragmatica.blogspot.com/2009/05/xsane-problems.html
---

This morning I scanned a small French reader that Marc particularly
liked. At noon I had to scan two pages for Angela, because she'd left
them at home. When I went to scan I got this: "Failed to start scanner:
Invalid argument".  
  
After much flailing, including re-installing hplip and xsane, and doing
sudo  
<blockquote>ln -s /usr/lib/libhpmud.so.0 libhpmud.so</blockquote>I
finally got brave and simply moved ~/.sane/xsane to ~/.sane/xsane.old,
then started xsane and it worked.  
  
After the fact, I figured out that the problem started when I clicked on
the preview pane in xsane and set the size of the area I was scanning to
0. The message wasn't very helpful. (I figured it out by diff'ing the
xsane.conf that worked with the one in xsane.old.)  
  
In addition, hp-check reports there's no plug-in installed for my
printer, even though everything seems to be working. Go figure.  
  
All this under Ubuntu 9.04 using an HP CM1312nfi MFP.

