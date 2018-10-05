---
layout: post
title: Definitive Guide to Recovering from a Full Disk
date: '2014-09-29T21:54:00.001-07:00'
author: Larry Reid
tags:
modified_time: '2014-09-30T06:38:47.029-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7970226611748674383
blogger_orig_url: http://technopragmatica.blogspot.com/2014/09/definitive-guide-to-full-disk.html
---

Cheap, stingy guy that I am, I allocate really small system partitions to my Ubuntu servers. This means that periodically my disk fills up. It fills up because every kernel upgrade takes a fair amount of space, and old kernels aren’t cleaned out automatically. Unfortunately, the disk usually fills up when trying to do an upgrade, so `apt-get` fails, and terminates with a partially installed package. You’ll know that has happened when you get a message like this when you run an `apt` command:

```
E: Unmet dependencies. Try using -f.
```

Once that happens, you can’t use any `apt` command.
There’s lots of advice out there about what to do, but the pages I’ve found always seem to leave something out, or assume knowledge of `apt` or `dpkg` that I don’t have.
So based on the last time this happened, here’s how I plan to recover the next time I run out of space. Warning: lots of Terminal commands coming up. I do everything in the Terminal for a few reasons:

* This happens to me most often with servers, as I’m trying to save space, especially for virtual machines. My servers don’t have a GUI
* Terminal works for both desktop and server machines
* It’s easier to document commands for the Terminal

First, I have to make sure the problem really is that I’m out of space. (Looking for 0 in the “Avail” column, on the line that has “/” under the “Mounted on” column):

```
df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       3.7G  3.7G     0 100% /
...
```

Then I find out what version of the kernel I’m running:

```
uname -a
Linux ixmucane 3.13.0-24-generic #47-Ubuntu SMP Fri May 2 23:30:00 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
```

Next, I find out what kernels are installed:

```
dpkg --list | grep linux-image
```

If I have at least two versions <i>older</i> than the one I’m currently running, I can remove the oldest one (replacing the “n.nn.n-nn” with the version number I want to remove):

```
sudo dpkg --purge linux-headers-n.nn.n-nn-generic
sudo dpkg --purge linux-headers-n.nn.n-nn
sudo dpkg --purge linux-image-extra-n.nn.n-nn-generic
sudo dpkg --purge linux-image-n.nn.n-nn-generic
```

This should free up lots of space, but I check again with `df -h`. Then run:

```
sudo apt-get -f install
```

If the amount of space it needs is less than what’s available according to `df -h`, then I go ahead and finish the install. To be safe, I also do:

```
sudo apt-get update
```

If there’s not enough space, and I have more old versions of the kernel installed, I just repeat the above `dpkg` until I have enough space to finish the install.

The above is the happy path. If I didn’t have two versions older than the current running kernel, I would try to remove the partially installed packages. Looking again at the output of:

```
dpkg --list | grep linux-image
```

if the newest version there is <i>newer</i> than the kernel currently running, then I would try the above `dpkg` commands to remove the partially installed packages. Some of them won’t work, of course, since the package isn’t installed, But once all the installed packages are removed, presumably there would more space and I could try:

```
sudo apt-get -f install
```

The reason I want to have two versions older than the current version is in case for some reason the current kernel doesn’t work, I can go back to the previous version. This is a cautious approach. If I’m really stuck, I would remove all versions except the current version. I’d probably make sure that I could boot the current kernel first. I haven’t had to do this and I hope I never do, but…
