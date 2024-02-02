---
layout: post
title: Movies at Home
date: '2014-11-11T11:14:00.001-08:00'
author: Larry Reid
tags: 
modified_time: '2015-01-05T20:32:24.865-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3590726835044466905
blogger_orig_url: http://technopragmatica.blogspot.com/2014/11/movies-at-home.html
---

I keep hearing about how we don’t need cable any more to watch movies or
TV. All the talk convinced me I should try. Well, talk about some
serious time wasting…

I wanted to:

* Put my DVDs onto a file server and play them, without having to load
  them in the DVD player
* Play on the TV anything I can see on my computer through my browser.
  In particular, I wanted to play TV from Guatemala. Some of the
  channels there stream a lot of their programming straight to the
  Internet
* Play Netflix, and possibly other services, with a decent selection of
  material. I had Netflix for a few months a couple of years ago but,
  living in Canada, we quickly ran out of material to watch
* Do everything in such a way that everyone else in the family can use
  the technology, once I get it set up

What have I managed to do?

* I can play my videos on my TVs, via a [Roku 3][1]. I’m also optimistic
  that I can get my [WDTV Live][2] to work as well. It required a lot of
  research, mostly because I had to convert the DVDs to a different
  format, and buy a big new storage device, a [Synology DS412+][3]
  [NAS][4] device
* I can play some stuff on my TV that I can play in a browser, but not
  everything. To be more accurate, I can play stuff from YouTube, but
  not anything else. This is quite useful, but not all that I wanted
* I haven’t tried Netflix with the VPN yet, but I don’t expect any
  issues. I have a VPN from [PureVPN][5]. Setting up the VPN the way I
  wanted it was a true adventure, not covered in this post
* The younger members of the family can use it, but *I’m* frequently
  frustrated by the number of hoops I have to jump through. It’s sure
  not like just turning on the TV and flipping through the channels

Some of this was surprisingly easy, and some required the typical
technology flailing that I get into. Overall, it’s a solution that
requires a certain amount of comfort with technical topics. I’m starting
to get my head around digital video, but I’m nowhere near an expert. I
also know a lot about Linux, and enough about networking to have an idea
of what I wanted to do.

This post will only talk about the process of getting my DVDs onto my
network and playing them from the TV. I’ll cover:

* The storage device for movies
* How to play a movie from the storage device on a TV
* How to put your DVDs on the storage device
* What if you want to do something different from what I did

# Storage   {#storage}

Video work requires lots of disk space. A non-HD movie from a DVD takes
more than a GB. In my experience, a typical movie DVD has more than 4
GBs on it. And the software for playing movies on a TV, at least the
software I found, doesn’t play from the ISO file (direct copy of a DVD),
so you have to convert it. In the process of converting, you may need
even more space.

The need for storage space was what made me buy the Synology DS412+ NAS
device, which runs [DSM 5.1][6], a [BusyBox][7]-based Linux machine.

The Synology doesn’t actually come with disks (so, for example, don’t
get excited about how cheap it is when you look up the price). You buy
the disks you want to put in it. That gives you the freedom to decide
how much storage to buy.

I bought the maximum of four disks, 3.5 in, with 3 TB capacity each, and
used the default formatting option, which is a type of [RAID-5][8]. The
result is that I have just under 8 TBs of usable storage space, plus the
ability to replace any single-disk that fails with no loss of data.

I ordered from [NCIX][9], which has a big presence where I live, so they
delivered in less than 36 hours. I had it running on my network in 48
hours after ordering. Total cost was around C$200 per usable TB.

(You could never get storage that fast and that cheap in the enterprise
IT world. I know it’s a bit unfair to compare, as it’s not completely
apples-to-apples, but seriously, CFOs need to ask their CIOs what
benefit the corporation is getting from overpaying for storage from
[EMC][10], [HP][11], [NetAPP][12], or [Hitachi][13]. They don’t get
responsiveness or agility. They sure don’t get cheap storage – at work I
pay $9,000 per TB. That’s right. 45 times as much.)

I thought about putting together my own storage box using an old
computer from [FreeGeek][14]. I’m sure it would have been a lot of fun
for a geek like me. The reality is that it wasn’t going to be much
cheaper, and it would have taken a *lot* more time.

Note: The DS412+ doesn’t appear on Synology’s site any more, so perhaps
there’s a newer equivalent.

# Playing DVDs   {#playing-dvds}

Once I got the Synology running, I was pleasantly surprised to discover
that I had something that serves up videos to a Roku 3. The Synology
comes with built-in software to be a media server.

The Roku 3 has an app called DS Media that works with the Synology media
server. I had to get it from Roku’s channel store, but that’s pretty
easy. It was under the “Audio and Video” category, and was free.

Once I had the DS Media channel on the Roku, all I had to do was upload
my movies, in the right format, to the “video/movie” folder on the
Synology. Getting them in the right format was the next trick – see the
next section.

I haven’t got the WDTV working with the Synology media server, but it
seems to recognize and connect to it, so I’m hoping…

I had started to play around with [Plex][15] on my home-built file
server, just enough that my free trial period had run out. Since the
Synology came with its own thing, I haven’t pursued Plex. A lot of
people like Plex.

# Ripping DVDs   {#ripping-dvds}

I figure if I buy a DVD, I can make a copy of it and watch it on my TV.
(I guess that’s my disclaimer that I’m not encouraging you to make
illegal copies of your videos.)

I already had a lot of DVDs copied to ISO images, by using:

> dd if=/dev/cdrom of=movie-name.iso

That’s a Linux terminal command. Mac users can do something similar in a
terminal. Windows users: you’ll have to figure it out for yourself.
Sorry.

It turns out, in this fancy modern world, video players don’t play ISO
files. It sort of makes sense. You don’t want to have to go through a
DVD’s menu if you’re watching on your phone or tablet.

It turns out that converting an ISO to a file playable by a phone,
tablet, or TV (like the Roku or WDTV) can be a savage journey into the
morass of video encoding. The morass includes open-source
[telenovelas][16] about competing projects ([this][17] seems to be a
relatively unbiased summary), patent-encumbered video formats, lossy
video formats, and differences in Linux distributions.

You can avoid most of that trip by doing this:

1.  Install VLC media player and [Handbrake][18] from your
    distribution’s repository. You don’t need to use VLC directly. VLC
    installs software that enables Handbrake to rip some, but not all,
    copy-protected DVDs
2.  Review [this link][19] for how to optimize the Handbrake conversion
    for the Roku. Standard DVDs don’t have HD video, so 480p is as good
    as it’s going to get
3.  Use Handbrake to rip your DVDs or ISO files to the open
    [Matroska][20] container format (.mkv). Matroska is now
    well-supported on Android and TVs/TV boxes like the Roku

If you want to play your videos on an Apple device, it’s more
complicated. In fact, I haven’t got it to work yet. The version of
Handbrake on distributions derived from Ubuntu 14.04, like Linux Mint
17, doesn’t support output to the MP4 container format, for software
patent reasons. The [MP4][21] container is the only format supported on
Apple products.

There are suggestions that I could build my own version of Handbrake
that would work, but one set of instructions I followed didn’t work, and
I haven’t pursued it further.

# Doing Something Different   {#doing-something-different}

Most of the time I spent on this was the research and learning. If you
want to try exactly what I did, and you’re comfortable Googling for
advice on technology topics, it’s not that hard.

However, there’s a good chance that you won’t want to do, or won’t be
able to, do exactly what I did. Here are some things to watch for:

* The Linux video world is constantly in flux. If you’re using versions
  after Ubuntu 14.04, or distributions not derived from Ubuntu, you
  should definitely confirm that you can rip your DVDs before you spend
  a bunch of time, and money on hardware for storage or playing
* If you’re not using Linux, confirm that Handbrake and VLC work on your
  version of Windows or Mac OS, and can do what you need
* If you have anything other than a Roku 3 for playing Internet TV, you
  need to find evidence on the Internet that your device can work with
  the Synology media server. Look for the evidence by Googling the name
  of your device and the model of Synology you plan to buy
* If you want to use a different storage device, you have to figure out
  whether it has a media server, and whether the media server is
  compatible with your TV device

# Summary   {#summary}

With a Synology NAS storage device, a Roku 3 with the DS Media channel,
my own DVDs, and Handbrake, I was able to convert DVDs to movie files,
store them on the storage device, and play them on a TV through the
Roku.



[1]: https://www.roku.com/products/roku-3
[2]: http://www.wdc.com/en/products/products.aspx?id=1270
[3]: https://www.synology.com
[4]: http://en.wikipedia.org/wiki/Network-attached_storage
[5]: http://www.purevpn.com
[6]: https://www.synology.com/en-uk/dsm/5.1
[7]: http://www.busybox.net/
[8]: http://en.wikipedia.org/wiki/Standard_RAID_levels
[9]: http://ncix.ca
[10]: http://emc.com
[11]: http://hp.com
[12]: http://netapp.com
[13]: http://hitachi.com
[14]: http://freegeekvancouver.org
[15]: http://www.plex.tv
[16]: https://lwn.net/Articles/423702/
[17]: https://github.com/mpv-player/mpv/wiki/FFmpeg-versus-Libav
[18]: http://handbrake.fr
[19]: http://www.rokoding.com/099_480p_dvd_original/
[20]: http://wikipedia.org/wiki/Matroska
[21]: http://wikipedia.org/wiki/mpeg-4
