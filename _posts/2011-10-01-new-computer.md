---
layout: post
title: A New Computer
date: '2011-10-01T19:39:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- New Computer
modified_time: '2012-01-30T12:31:28.691-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5650039940030798062
blogger_orig_url: http://technopragmatica.blogspot.com/2011/10/new-computer.html
---

The backlight died on my Lenovo x300 a couple of weeks ago, so I bought
a Dell Vostro with Ubuntu pre-installed. Here's how I got from one to
the other:  
  
The Dell website said I was getting Ubuntu 11.04, but out of the box the
computer had 10.10 on it. My first try upgrading to 11.04 failed. When
it tried to reboot, it said the device for / wasn't ready. Fortunately,
I somehow got to the old grub screen that let me choose which image to
boot, and at the bottom there was an option to return the box to factory
state.  
  
I tried that, and it worked. I had about 10 minutes of the spinning
"wait" cursor before it started doing something, but by being patient I
got the box back to factory state.  
  
So I went through the process of updating 10.10, reboot, then upgrade to
11.04 again. This time I saved the sudoers file. I was asked whether to
keep the old one or use the new one as part of the installation.  
  
I'm going to force myself to use Unity for a while. That's causing me
some grief, but I'm already finding so of the tricks that make Unity
more productive (try right-clicking the "Applications" or "Files &amp;
Folders" icons in the Launcher bar).  
  
To get my old files over from the old computer, I connected a 1 TB USB
drive to the old laptop, shut down Evolution, virtual machines, and any
other applications that might be updating files while I copied, and did:

`sudo cp -a /home /media/wd1tbb/home `  
  
I have a lot of software installed on the old machine. I found excellent
instructions [here][1] about how to move Ubuntu from one machine to
another, preserving your environment and installed software as much as
possible. The instructions are for when both machines are running
exactly the same version of Ubuntu.  
  
I was moving from 10.04 to 11.04, so I didn't meet the criteria. I
generated the list of installed packages anyway, and took a look at the
list using a text editor. The vast majority of the packages are what I'd
call supporting or system packages. So I think I'll skip that step.  
  
But wait. The Ubuntu Software Centre has a better idea of what's an
application package. I'll have to look into where it gets its list.  
  
Any, back to copying my file. I did:  
`sudo cp -aiv /media/wd1tbb/home/reid /home `  
  
Then I used judgement to decide whether to overwrite or not.  
  
Argh! For some reason, the new computer has the original user with
uid=1001, not uid=1000 like every other Ubuntu I've installed. I had to
run commands like this to fix up the files I copied over:  
  
`sudo find /home -gid 1000 -uid 1000 -exec chown -h 1001:1001 \{} \;`  
  
Then, probably because I've upgraded versions of Evolution, just copying
the files across wasn't enough. I had to go back to the old machine and
make an Evolution backup, copy it to the new machine, and set up
Evolution from the backup. This was made more interesting because the
Evolution setup wizard would show the text in each window for only a few
seconds, then it would disappear. By fiddling and trying a few times I
was able to get Evolution going. (A lot of work considering I may well
switch back to Thunderbird soon.)  
  
That's the basics. I think I'll post this now, and add new posts for all
the other work I'll have to do (like lower the sensitivity of the touch
pad).



[1]: http://eggsonbread.com/2010/01/28/move-ubuntu-to-another-computer-in-3-simple-steps/
