---
layout: post
title: Android Phone Not Connecting via DHCP
date: '2016-04-17T20:49:00.000-07:00'
author: Larry Reid
tags:
- Network
- Android
modified_time: '2016-04-17T20:49:10.222-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-700609292797841330
blogger_orig_url: http://technopragmatica.blogspot.com/2016/04/android-phone-not-connecting-via-dhcp.html
---

I had a weird problem where suddenly my phone stopped connecting to my
home WiFi. I was getting the WiFi icon with the exclamation mark,
meaning that the router was connecting but I wasn't getting all the info
needed to participate in the network.  
  
(The solution further down doesn't require you to understand the next
couple of paragraphs, so don't despair if there's too much tech talk in
what follows.)  
  
Many posts on-line suggested using a static connection. I was able to do
that at home, because I knew the range of DHCP addresses that my router
would not give out. But I wasn't satisfied with that solution. I hate it
when problems mysteriously arise, and I couldn't identify any reason why
my network connection at home should have suddenly started failing.  
  
About the third time I looked for a solution, I came across
this [document from Princeton][1]{: target="_blank"}. It mentions that
there's a bug in some Broadcomm chips that messes up DHCP when the
network stays on when the device is asleep.  
  
Well, I remember noting that I had my network configured to stay up when
the device was asleep. I noticed it because I didn't think I had
configured it that way. (I sometimes find my phone on the settings
screen when I pull it out of my pocket, and settings are accidentally
changed.)  
  
So (here's the solution), I went back to Settings-&gt; WiFi, then
touched the three dots near the top right of the screen, then Advanced,
then I turned off "Keep Wi-Fi on during sleep", which set my network to
go off when the device sleeps. After that, my phone connected to my home
network just fine.  
  
My phone is a Nexus 4, running Android 5.1.1, but obviously this might
affect other models since it looks like it's because of the hardware.



[1]: https://www.net.princeton.edu/android/android-stops-renewing-lease-keeps-using-IP-address-11236.html
