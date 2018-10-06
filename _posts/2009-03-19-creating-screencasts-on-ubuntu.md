---
layout: post
title: Creating Screencasts on Ubuntu
date: '2009-03-19T14:46:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- Collaboration
- PAC
modified_time: '2009-04-17T07:04:09.398-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8787607570862051506
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/creating-screencasts-on-ubuntu.html
---

I'm building a web site using Drupal 6 for my son's school's parent advisory council. The idea of the site is to facilitate community participation. Since we're a volunteer group and we aren't at the same workplace every day, I thought screencasts might be a great way to help people learn how to use the site.

This post covers the technical how-to for screencasts with Ubuntu 8.10 on a Lenovo x300. When we get some feedback about whether the screencasts are helpful, I'll post about the social part of the experience.

It took me an afternoon and a morning of thrashing to get everything working. Here's what I did:

1. Install `gtk-recordmydesktop` and `gnome-alsamixer`:
```
    sudo apt-get install gtk-recordmydesktop gnome-alsamixer
```

2. Open Applications-> Sound & Video-> GNOME ALSA Mixer and make sure the microphone is recording and isn't muted. The controls you have available in the ALSA Mixer depend on your sound hardware, so you may have to do some research on your own to find the right settings for your sound card. At this point, you should be able to record sound and video with RecordMyDesktop (Applications-> Sound & Video-> gtk_recordMyDesktop)

3. If you find that the sound stutters on playing back your screencast, run `recordmydesktop` from a terminal window. If you see "Broken pipe: Overrun occurred.", the problem is when you record the screencast, not on playback. I installed the Jack audio server and that fixed it

To install Jack and use Jack,

1. Install (I think this is right -- I installed using the Synaptic GUI)

    ```
    sudo apt-get install jackd libjack-dev
    ```

    Note that including the development library (`libjack-dev`) is very important. If you don't include it, you'll get an error when you start recording with RecordMyDesktop ("dlopen/dlsym error on libjack.so")

2. Do Applications-> Sound &amp; Video-> JACK Control

3. Click on Start in the JACK window

4. Do Applications-> Sound & Video-> gtk_recordMyDesktop

5. Click on Advanced

6. Click on the Sound tab and make it look like this

    {% asset record-my-desktop-advanced.png %}

7. Close the window

8. Record the screencast (Select Window if you want, then click Record)

9. When you're done, *stop Jack and Quit from the control window before you try to play back the screencast.* I found that playback would freeze up if Jack was still running. This is a moderately big nuisance, but I haven't found a way to make it work with Jack open.

`recordmydesktop` creates a video file in .ogv format, which isn't a commonly installed codec on Windows Media Player or Quicktime (on Windows, at least). However, if you upload the video to YouTube, it will be converted to a format watchable anywhere, as far as I can tell. You do seem to lose some quality of video in the conversion. There are video conversion tools available for Ubuntu, but I haven't tried to convert myself. I don't know if that would help the YouTube resolution anyway, as the more times you convert video the worse it tends to be.
