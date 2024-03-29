---
layout: post
title: Ubuntu and Mint Very Slow
date: '2012-09-16T08:41:00.001-07:00'
author: Larry Reid
tags:
- Ubuntu
- Mint
modified_time: '2012-09-16T08:41:17.922-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5322467179238834874
blogger_orig_url: http://technopragmatica.blogspot.com/2012/09/ubuntu-and-mint-very-slow.html
---

I've been struggling for some time with poor performance of
[Ubuntu][1]{: target="_blank"}, and now [Mint][2]{: target="_blank"}, on
my Dell Vostro 1440. Admittedly it's a cheap laptop, but in this day and
age a Linux desktop should run decently on pretty much anything, as long
as you're not using a lot of fancy desktop effects.  
  
Running top I was seeing a lot of wait time. When the performance was
really bad, I'd see over 90 percent wait time. Typically I'd be dipping
into swap space when performance was bad, but it would be bad without
swapping (I "only" have 2 GB of RAM). I would see this when running only
Thunderbird and Chrome, although Chrome with a lot of tabs open.  
  
I spent many frustrating hours Googling for performance issues on Ubuntu
or Mint and didn't find anything really promising.  
  
Finally, last weekend I was dropping off some old computer gear for
recycling at our local [Free Geek][3]{: target="_blank"} and saw a
pretty sweet Dell laptop for sale. I started playing with it, partly to
see how it performed. They sell used computers with Ubuntu, and Ubuntu
comes with Firefox. Firefox was snappy as all get out, and on a lower
powered CPU than mine at home.  
  
So I went home and tried Firefox. It works great. So I started Googling
performance problems with Chrome on Linux and got all sorts of hits.
[This one][4]{: target="_blank"} looks like it's turning into a bit of
an omnibus bug report, but has some good info and links to other places.

  
It looks like one factor is that Google has made its own Flash viewer,
since Adobe is no longer supporting new versions of Flash on Linux. Many
people report disabling the Google Flash viewer helps, but it didn't
work for me.  
  
Others report that it is indeed due to memory usage of Chrome with many
tabs. Others report that it has something to do with using hardware
graphics rendering, that the hardware is actually slower. Still others
report issues with Chrome scanning for devices, and particularly
webcams.  
  
My gut says it's a combination of things -- perhaps all of the above are
involved, but you only see the performance problem when two or more of
the factors coincide.  
  
I haven't found a solution that works for me yet, so I'm somewhat
reluctantly using Firefox. It's certainly a lot faster than it was two
years ago. However, I miss the combined link and search field in Chrome,
amongst other things. It does seem like Firefox has stolen most of
Chrome's good ideas, so it's not as hard as I thought it might be to
readjust.



[1]: http://technopragmatica.blogspot.ca/2012/02/sluggish-ubuntu-video.html
[2]: http://technopragmatica.blogspot.ca/2012/09/use-mate-with-cheap-hardware.html
[3]: http://freegeekvancouver.org/
[4]: http://code.google.com/p/chromium/issues/detail?id=138876
