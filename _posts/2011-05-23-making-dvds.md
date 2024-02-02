---
layout: post
title: Making DVDs
date: '2011-05-23T10:30:00.000-07:00'
author: Larry Reid
tags:
- DVD
- Ubuntu
modified_time: '2011-05-23T10:30:55.266-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6768037851087377160
blogger_orig_url: http://technopragmatica.blogspot.com/2011/05/making-dvds.html
---

My son's class at school raised and released some salmon this spring,
and he had a project to produce a video about it. I offered to edit the
raw video together. That spun into a project where I ended up putting
together four short videos. Then I put them all on one DVD with a menu.
Of course, it wasn't easy. It turned into another episode of all my
spare time for two weeks being spent trying to do something useful with
a computer.  
  
First I had to find the right tools for Ubuntu (10.04 in my case). It
turns out that Kino, the video editor I had used before, is no longer
under active development. It looks like everyone is using [OpenShot][1]
now. It's in the Ubuntu repository, but I found there were sufficient
new features with the more recent version that I followed the
[instructions][2] to get it from their PPA repository.  
  
I found OpenShot to be quite intuitive. There's also pretty good
[documentation][3]. I think I observed a few random crashes, so it's
worthwhile to remember to save your work frequently. There is an
autosave feature as well, but you have to find it and turn it on. It
isn't on by default.  
  
OpenShot will take your completed video project and turn it into a DVD
image ready to burn. That's very slick. My earlier attempts at producing
DVDs led to a lot of command line fiddling, and I found it very easy to
burn DVDs that didn't actually work. OpenShot made it easy.  
  
The next part of my challenge was to put four videos on the DVD and
stick a menu on the front. I found documentation [here][4] and [here][5]
and elsewhere on how to do it (the [colour scheme][6] is a killer).
However, it turns out that making DVD menus is very picky and error
prone, at least for me. I never got anything working consistently.  
  
Finally I found [DVD Styler][7]. Again, it's in the Ubuntu repository so
it's easy to install. It has a GUI and lets you set up a menu, including
automatically doing the typical "Play all or episode selection" scenario
if you have multiple videos.  
  
There were a couple of tricks I discovered along the way:  
  
<ul><li>Some of the original videos were shot in HD. OpenShot can't deal
with HD. I had to use ffmpeg to convert the format to ordinary MPEG-2
video ("ffmpeg -i input.mp4 -target ntsc-dvd -y output.mpg" if you're
making a DVD for North America)</li><li>OpenShot by default makes a DVD.
You don't want that when you're planning to use DVD Styler to make a
menu. I had to go back and re-export my videos from OpenShot as "mpeg2"
videos</li><li>DVD Styler sets up the DVD menu buttons to use "auto"
navigation. That didn't work on my cheap DVD player. I had to go into
the properties window for each menu button, and under "focus", change
the target of each button to the explicit value I needed (this
description will make sense when you look at the properties window for
the buttons)</li></ul>DVD Styler lets you simply preview the menu,
create an ISO file, or go straight to burning the DVD. I created the ISO
so I could test it with video players (I used VLC and mplayer). Using
the players didn't expose the menu button problem I mention in the
second bullet above, but otherwise was a worthwhile step.  
  
I didn't try to do anything but the default menu background in DVD
Styler. If you've done it, please comment here with your experience.  
  
Unfortunately, I can't post the final product. Since it was done at
school, they're very careful not to release anything publicly when they
don't have all the parents' permission. Makes sense, of course.



[1]: http://www.openshotvideo.com/
[2]: http://www.openshot.org/ppa/
[3]: http://www.openshotusers.com/help/1.3/en/
[4]: http://www.tappin.me.uk/Linux/dvd.html#menus
[5]: http://radagast.bglug.ca/linux/dvd_authoring/dvd_authoring.html
[6]: http://floatinginspace.za.org/spumux/spumux.html
[7]: http://www.dvdstyler.de/en/
