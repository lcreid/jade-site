---
layout: post
title: Backlight with Ubuntu 8.10 and Lenovo X300
date: '2009-02-07T07:28:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
- Lenovo x300
modified_time: '2009-02-07T07:41:54.037-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7627921941891986916
blogger_orig_url: http://technopragmatica.blogspot.com/2009/02/backlight-with-ubuntu-810-and-lenovo.html
---

A recent kernel upgrade broke the backlight control on my X300 (along
with a lot of other laptops, according to what I find with Google). To
fix it, I'm running the following every time I log in:  
<pre>  
sudo xrandr --output LVDS --set BACKLIGHT\_CONTROL legacy</pre>

