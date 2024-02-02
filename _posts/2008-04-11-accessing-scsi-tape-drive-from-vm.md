---
layout: post
title: Accessing a SCSI Tape Drive from a VM
date: '2008-04-11T18:35:00.000-07:00'
author: Larry Reid
tags:
- Backups
- VMWare
- Ubuntu
- Dell
modified_time: '2008-04-12T07:51:40.549-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6161569174372960447
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/accessing-scsi-tape-drive-from-vm.html
---

I ordered my Dell SC440 with an internal DAT tape drive. <span
style="font-family:courier new;">lsscsi</span> reports it as a Seagate
DAT72-052. I'm pretty sure that the Ubuntu 6.06 installation picked it
up automatically -- I flailed around a bit to get this working but I
don't think at the end of the day that I did anything on the host to get
the tape drive working.  
  
I'm creating a VM to run my backup. For large installations you won't
want to do this, but for me I see no reason not to. And a big part of
the reason I'm doing this is to see what's possible, so onward.  
  
To enable the tape on a VM, you have to shut down the VM. Then, in the
VMWare Console select VM > Settings > Hardware > Generic SCSI, and
specify the physical device to connect to. In my case it was <span
style="font-family:courier new;">/dev/sg0</span>. You also have to
specify the controller and target for the tape drive.  
  
I had no idea what the controller and target were, so on the VMWare
host, I did:  
<span style="font-family:courier new;"><blockquote>sudo apt-get install
lsscsi  
lsscsi -c</blockquote></span>and got:  
<span style="font-family:courier new;" /><blockquote><span
style="font-family:courier new;">Attached devices:</span>  
<span style="font-family:courier new;">Host: scsi1 Channel: 00 Target:
06 Lun: 00</span>  
<span style="font-family:courier new;"> Vendor: SEAGATE Model: DAT
DAT72-052 Rev: A16E</span>  
<span style="font-family:courier new;"> Type: Sequential-Access ANSI
SCSI revision: 03</span>  
<span style="font-family:courier new;">Host: scsi2 Channel: 00 Target:
00 Lun: 00</span>  
<span style="font-family:courier new;"> Vendor: ATA Model: WDC
WD1600YS-18S Rev: 20.0</span>  
<span style="font-family:courier new;"> Type: Direct-Access ANSI SCSI
revision: 05</span>  
</blockquote>I took the channel as the controller: 0, and the target: 6.
I entered all that into the VMWare Console and clicked enough okays to
get out of the configuration. (I couldn't find the link in VMWare's
on-line documentation for configuring generic SCSI devices, but if you
type "SCSI" in the "Index" tab of the VMWare Console's help window you
can find slightly more detailed instructions.)  
  
When I started the VM, I got a message that said, among other things:
"Insufficient permissions to access the file." Since it looked like
everything else was right, I did <span style="font-family:courier
new;">ls -l /dev/sg0</span> on the VMWare host (not the VM) and got:  
<span style="font-family:courier new;" /><blockquote><span
style="font-family:courier new;">crw-rw---- 1 root tape 21, 0 2008-03-23
17:23 /dev/sg0</span> </blockquote>Since VMWare was running as user
<span style="font-family:courier new;">vmware</span>, I added the <span
style="font-family:courier new;">vmware</span> user to the <span
style="font-family:courier new;">tape</span> group:  
<span style="font-family:courier new;"><blockquote>sudo adduser vmware
tape</blockquote></span>Then I restarted the VM and it worked fine. It
pays to read the error message closely.

