---
layout: post
title: Upgrading Android Phone With Linux
date: '2012-07-22T14:47:00.000-07:00'
author: Larry Reid
tags:
- Android
modified_time: '2012-09-03T07:46:05.421-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8376325335984734322
blogger_orig_url: http://technopragmatica.blogspot.com/2012/07/upgrading-android-phone-with-linux.html
---

I've had a Samsung Galaxy S II with Android 2.3.3 from Virgin Mobility
in Canada since last year at this time. Part of the reason I went
Android is I wanted to get away from having to have a Windows VM just to
manage my phone. When I got the Galaxy I asked how upgrades worked, and
I was told it was a stand-alone upgrade.  
<span style="background-color: white;">  
</span><span style="background-color: white;">Time goes by and I rather
enjoy not having my phone's behaviour change every time I plug it in to
my computer. For that matter, I enjoy not having to plug it into a
computer all the time. Lately, however, some of the things that I didn't
like about my phone bugged me enough that I thought I should do
something about them. And before doing that, I thought, well I better
upgrade Android first.</span>  
<span style="background-color: white;">  
</span><span style="background-color: white;">So it turns out I needed a
PC or a Mac to upgrade using the Samsung Kies software. No stand-alone
upgrade like they told me. Crap. Well, I thought, I'm a Linux user so
suck it up and Google for the solution. Many Androids do indeed have a
stand-alone upgrade on the phone, and people report it works quite well,
although it's best to be connected to WiFi first. I suspect, therefore,
that either it's something that Virgin/Bell did to their version of
Android, or it's an artefact of the old version of Android.</span>  
<span style="background-color: white;">  
</span><span style="background-color: white;">In other words, these
instructions are only for if you can't find the stand-alone upgrade on
your phone. Look under Settings-&gt; About Phone.</span>  
<span style="background-color: white;">  
</span><span style="background-color: white;">Without the stand-alone
upgrade, here's what I did:</span>  
<ol><li>I went to [samfirmware.com][1] to find the version of software
for my exact model of phone, a GT-I9100M and download it. The version I
got was 4.0.3 (Ice Cream Sandwich)</li><li>I uncompressed
it</li><li>Heimdall is the Linux program to flash the Samsung's
firmware. I [downloaded heimdall][2]{: target="_blank"} 1.3.1, both
frontend and the base, from the [heimdall github site][3]{:
target="_blank"}. At the time I wrote this, heimdall 1.3.2 was the most
recent, but apparently it had an issue and the Internet recommended
using 1.3.1</li><li>I installed each of the .deb files by
double-clicking on them</li><li>I ran "sudo heimdall-frontend" in a
terminal. I had to run it with sudo or I would get a "libusb error: -3"
\[Update: On another system I got "heimdall-frontend: error while
loading shared libraries: libz.so.1: cannot open shared object file: No
such file or directory" when I installed the 32-bit Heimdall on a 64-bit
Linux Mint.\]</li><li>Somewhere around here you may want to back up your
phone. I didn't, but I was quite confident that most of what I have on
the phone is also in the cloud somewhere. I copied all my photos to my
computer before starting the upgrade</li><li>The phone has to be in
"download mode" before connecting to it with heimdall. To put it in
download mode, turn off the phone, disconnect the USB cable, and hold
down Volume-Down, Power, and Home all at the same time for a few
seconds. The phone shows a display that it's in download mode within a
couple of seconds. To quit without downloading anything, just hold down
the power button for five seconds or
so ([http://forum.xda-developers.com/wiki/Samsung\_Galaxy\_S\_II\_Series#Download\_Mode][4])</li><li>I
prepared the firmware to flash according to the Heimdall
instructions: [https://github.com/Benjamin-Dobell/Heimdall/tree/master/Linux][5],
under the heading "Performing a Custom Flash with Heimdall Frontend".
Note that the instructions say to get the PIT file from the phone
first</li></ol><span style="background-color: white;">It took a couple
of minutes to download all the files. For the larger files the feedback
would pause every once in a while. I was patient and waited and it
continued after a brief pause.</span>  
<span style="background-color: white;">  
</span><span style="background-color: white;">Once it's done the phone
rebooted and set about doing a bunch of post-install updating. It took
maybe ten minutes tops and the phone was ready to go. My memos were
still there. </span><span style="background-color: white;"> </span><span
style="background-color: white;">I lost all my playlists. As far as I
can tell, that's all I lost (but then I don't have a lot of stuff on my
phone that isn't in the cloud).</span>  
  
Finally, an annoying irony: One of the first things I noticed when I
started to use the new version is that it does indeed support a
stand-alone upgrade, so now all I need to do is connect to WiFi and
upgrade.



[1]: http://samfirmware.com/
[2]: https://github.com/Benjamin-Dobell/Heimdall/downloads
[3]: https://github.com/Benjamin-Dobell/Heimdall
[4]: http://forum.xda-developers.com/wiki/Samsung_Galaxy_S_II_Series#Download_Mode
[5]: https://github.com/Benjamin-Dobell/Heimdall/tree/master/Linux
