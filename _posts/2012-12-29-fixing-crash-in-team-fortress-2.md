---
layout: post
title: Fixing a Crash in Team Fortress 2
date: '2012-12-29T08:47:00.001-08:00'
author: Larry Reid
tags:
- Team Fortress 2
modified_time: '2013-04-07T08:25:29.602-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2904556308381059078
blogger_orig_url: http://technopragmatica.blogspot.com/2012/12/fixing-crash-in-team-fortress-2.html
---

My son wanted [Team Fortress 2][1] for Christmas. So far we've been
mostly blessed with not having to feed a relentless video game appetite
(aside from [Minecraft][2]). But I looked into it, and the game was
free, with a *very* recently released Linux version. So I thought, "what
the heck. It would probably only take me a few hours of fooling around
to make it work."  
  
Well, it was more than a few hours, but mostly because of my insistence
on doing things "right".  
  
TF2 is an interesting game. It runs in an environment, or framework, or
something, called [Steam.][3]{: target="_blank"} Steam supports many
other games. In fact, it appears to be a whole ecosystem of games and
communities around the games. There's a [.deb][4] to install Steam on
Debian-derived LInuxes, and that's the first thing I installed.  
  
I followed the Ubuntu [forum][5] for the installation, specifically
using the experimental nVidia driver. I have a 9300, which is less than
the forum says I need (9600 and above). Using the experimental driver
allowed me to get Steam to run.  
  
You have to sign up to the Steam community to use it. You can do so in
the game.  
    
To install TF2, I started Steam and found it in the on-line store. It's
a *long* download. I think it took five or six hours on my reasonably
fast ADSL. (I usually get 250-300 KB/s).  
  
Finally, I could run the game under my user.   
  
Here's where my insistence on doing it "right" first caused issues. My
son has his own Linux user on his computer, which is not the user that
installed Linux. His user was created as an ordinary non-admin user. My
son doesn't have any special privileges on his computer, which is fine
for me at his age. I don't want him to be able to mess up the
configuration of his computer.   
  
TF2 gets installed under the user's home directory, so I had to download
again for my son. (You could probably just copy the appropriate
directory or directories from one user to the other, but that would make
the problem of getting the game running even harder if it didn't work
the first time, which it didn't.)  
  
Trying to run the game from my son's user name caused some disk activity
and a few progress dialogues to appear, but then I'd just end up staring
at the Steam home page after a few minutes. Running Steam from the
command line allowed me to see all sorts of output, including the report
of a "Segmentation fault" at the time the disk activity stopped.  
  
Many hours of thrashing about and googling followed. Finally, it dawned
on me that the only real difference between the users (mine and my
son's) had to be the groups that they were in. (The Linux security model
allocates some privileges to "groups" rather than directly to users. You
then assign the user to a group to allow them the privileges of the
group.)  
  
Some trial and error fairly quickly determined that the user running TF2
has to be in the "sambashare" group. I logged in as me, the user who
installed Linux. Then, in a Terminal, I could have typed:  
  
sudo adduser *user* sambashare  
  
However, I got intrigued that I couldn't find the GUI do manage users
and groups. I discovered that it doesn't come installed by default on
Linux Mint 13. So I installed the Gnome system tools:  
  
sudo apt-get install gnome-system-tools  
  
With the Gnome system tools installed, I:<ol><li>Went to Menu-&gt;
Administration-&gt; Users and Groups</li><li>Selected my son's user
name</li><li>Clicked "Advanced Settings"</li><li>Entered my
password</li><li>Clicked the "User Privileges" tab</li><li>Checked the
box beside "Share files with the local network"</li><li>Clicked OK all
the way out again.</li></ol>  
Note that I did all the above as myself, the user who installed Linux,
not as my son.  
  
Now I logged out of my session and logged in as my son and TF2 ran. Woo
hoo!  
  
Note that the LInux version of Steam and/or TF2 is very new right now
(end of December, 2012). I found a lot of info on the net was no longer
applicable, because of the evolution of the game and the platform. Even
the contents of the Ubuntu forum for Steam changed drastically in the
few days that I was working off and on to get the game running.  
  
Off topic, but of interest to my geek friends: Here's a [blog post][6]
about how the Steam effort is contributing to better graphics support in
the Linux world.



[1]: http://www.teamfortress.com/
[2]: https://minecraft.net/
[3]: http://store.steampowered.com/
[4]: http://store.steampowered.com/about/
[5]: https://wiki.ubuntu.com/Valve
[6]: http://blogs.valvesoftware.com/linux/faster-zombies/
