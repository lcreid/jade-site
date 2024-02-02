---
layout: post
title: Configuring Bacula Tray Monitor on Ubuntu
date: '2010-11-14T07:51:00.000-08:00'
author: Larry Reid
tags:
- Backups
- Bacula
modified_time: '2010-11-14T07:51:02.553-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8174736114657160985
blogger_orig_url: http://technopragmatica.blogspot.com/2010/11/configuring-bacula-tray-monitor-on.html
---

I use [Bacula][1] to back up my servers and desktop/laptop
computers. It's always bugged me that I didn't have a little icon on my
Ubuntu desktop showing the status of the backup: whether it was running
or not and some indication of progress. Most backup systems have this.
In Bacula it's called the tray monitor. The [configuration file
documentation][2] seemed straightforward, but it took a lot of fiddling
to get it right.  
  
I think I have a fairly typical situation:  
<ul><li>A backup server with a direct attached backup storage device (in
my case, two: a USB-connected 1 TB hard drive, and a DAT-72 tape
drive)</li><li>Several clients being backed up on a regular
schedule</li><li>One client is the laptop I use as my normal
workstation. This is the one I want to put the tray monitor
on</li><li>I'm already successfully backing up this configuration, so
all my passwords in my Bacula configuration files are correct, and all
my firewalls are configured to allow the backup to work</li><li>The
laptop and the backup server are both running Ubuntu
10.04</li></ul>Here's what I did to get the tray monitor to work (read
my notes below before you start cutting and pasting the following into
your configuration):  
<ol><li>I installed the tray monitor software on my
laptop:</li><pre>`sudo apt-get install bacula-traymonitor`</pre><li>On
my laptop I changed the tray monitor configuration file
(`/etc/bacula/tray-monitor.conf`) to look like this:</li><pre>`Monitor {
Name = backup02-mon  Password = "Monitor-Password"  RefreshInterval = 5
seconds}Client {  Name = pacal-mon  Address =
pacal.pender.jadesystems.ca  FDPort = 9102  Password =
"Monitor-Password"}`</pre><li>Still on the laptop, I added the following
to the file daemon, aka backup client, configuration file
(`/etc/bacula/bacula-fd.conf`):</li><pre>`# Restricted Director, used by
tray-monitor to get the#   status of the file daemonDirector {  Name =
backup02-mon  Password = "Monitor-Password"  Monitor = yes}`</pre><li>I
restarted the file daemon on the laptop (don't forget this or you'll
confuse yourself horribly):</li><pre>`sudo service bacula-fd
restart`</pre><li>On the backup server, I added the following to the
director configuration file
(`/etc/bacula/bacula-dir.conf`):</li><pre><div>`# Restricted console
used by tray-monitor to get the status of the
director`</div><div>`Console {`</div><div>`  Name =
backup02-mon`</div><div>`  Password =
"Monitor-Password"`</div><div>`  CommandACL = status,
.status`</div><div>`}`</div></pre><li>Finally, I reloaded the
configuration file on the backup server:</li><pre>`sudo bconsole reload
exit `</pre><div><li>Now all I had to do is start the tray monitor. The
command line is:</li><pre>`bacula-tray-monitor -c
/etc/bacula/tray-monitor.conf`</pre></div></ol>Then I made a menu item
for it. I put it in Applications-&gt; System Tools.  
<ol><li>Select System-&gt; Preferences-&gt; Main Menu</li><li>Select
"System Tools" on the left side of the window</li><li>Click on the "New
Item" button on the right side of the window</li><li>Fill in the "Name:"
box with "Bacula Tray Monitor" and the "Command:" box with the command
line above</li><li>Click "OK"</li><li>Click "Close" in the "Main Menu"
window</li></ol>Notes:  
<ul><li>I used a separate password specifically for the monitor. The
tray monitor's configuration file has to be readable by an ordinary user
without special privileges. So anyone can see the password. Don't use
the same password for the monitor as you use for the director or the
file daemons, or you'll be making it easy for anyone who gets access to
your computer to read all the files on your network.</li><li>You have to
change to above bits of configuration file to match your particular
configuration. Change: "laptop.example.com" to the fully qualified
domain name of the computer on which you're installing the tray monitor.
Change "Monitor-Password" to something else more secure that everyone
who reads this blog doesn't know about. </li><li>"backup02-mon" and
"laptop-mon" are both names you can change to be anything you want them
to be. In my case, "backup02-mon" means the monitor on the backup server
(hostname: backup02), and "laptop-mon" means the monitor on the laptop
(hostname: laptop)</li></ul>



[1]: http://www.bacula.org/
[2]: http://bacula.org/5.0.x-manuals/en/main/main/Monitor_Configuration.html#13700
