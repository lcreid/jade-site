---
layout: post
title: Sluggish Ubuntu Video
date: '2012-02-16T23:08:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
- New Computer
modified_time: '2012-02-16T23:08:52.305-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1677813317175912267
blogger_orig_url: http://technopragmatica.blogspot.com/2012/02/sluggish-ubuntu-video.html
---

| Since I got my Dell Vostro 1440, I felt that it wasn't quite as responsive as it should have been. Yesterday I spent a little time trying to figure out why that might be. (A little time -- like all morning.) I stumbled across what seemed like good instructions on troubleshooting Linux video. At the start of all the instructions was a warning to make sure the user was in the video group. If not, the user's desktop wouldn't be able to use the graphics hardware.  
  
Well I checked my groups, and sure enough I wasn't in the video group. I added myself to the video group, and after logging out and in, and a day of use, I'm confident in saying that the desktop is much more responsive.  
  
More Googling turned up a useful command: 'glxinfo | grep "direct rendering"'. It will tell you "yes" if you're going straight to the graphics hardware.  
  
 |

