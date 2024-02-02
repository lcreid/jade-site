---
layout: post
title: Getting to Xubuntu
date: '2012-05-23T17:52:00.002-07:00'
author: Larry Reid
tags: 
modified_time: '2012-05-23T17:52:34.635-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8158742636392284268
blogger_orig_url: http://technopragmatica.blogspot.com/2012/05/getting-to-xubuntu.html
---

I don't want to start a flame war, but I've been unable to adjust to
Unity. So I've been using Xubuntu for some months now. I just installed
the Xubuntu packages over my Ubuntu 11.10 from the instructions
here: [http://www.psychocats.net/ubuntu/xfce][1]{: target="_blank"}.  
  
After installing Xubuntu, some things still seemed to be weird. Much of
it I could imagine might have to do with the fact that I had a lot of
perhaps unnecessary Ubuntu stuff hanging around my system. So yesterday
I finally followed the excellent instructions
at: [http://www.psychocats.net/ubuntu/purexfceoneiric][2]{:
target="_blank"} to get rid of the unnecessary stuff.  
  
I had to reinstall LibreOffice and a few other packages after following
the instructions. It's worthwhile to capture the output of the command
given by the link above, so you can see what's been removed.  
  
I had one obscure problem that gave me many hours of angst. When I
restarted my computer, it wouldn't boot. By booting to a live CD and
checking /var/log/syslog, and Googling, I discovered that
/etc/lightdm/lightdm.conf was sending me to the unity-greeter. I had to
change /etc/lightdm/lightdm.conf to look like this, and then I could
happily boot again:  
  
  
\[SeatDefaults\]  
greeter-session=lightdm-gtk-greeter  
user-session=  
  
I knew that after switching to Xubuntu but before following the above
instructions, my startup was still going to the Ubuntu login screen,
rather than the Xubuntu login screen. Part of the reason I was trying to
go to "pure" Xubuntu was to get rid of the Ubuntu login and get to a
pure Xubuntu experience.  
  
I can't say enough good things about [pyschocats][3]{: target="_blank"}.
She has done an excellent job of documenting a number of tricky topics.



[1]: http://www.psychocats.net/ubuntu/xfce
[2]: http://www.psychocats.net/ubuntu/purexfceoneiric
[3]: http://www.psychocats.net/ubuntu/index
