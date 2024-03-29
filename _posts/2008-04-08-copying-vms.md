---
layout: post
title: Copying VMs
date: '2008-04-08T18:30:00.000-07:00'
author: Larry Reid
tags:
- Backups
- VMWare
- Virtualization
- Ubuntu
- IT Infrastructure
modified_time: '2008-04-09T05:57:51.197-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4888897626996764079
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/copying-vms.html
---

I tried copying my tiny Ubuntu VM, and it ran, except <span
style="font-family:courier new;">eth0</span> wouldn't come up, and of
course the host name was wrong.  
  
To fix <span style="font-family:courier new;">eth0</span>, you have to
update <span style="font-family:courier new;">/etc/iftab</span> with the
new VMWare-generated MAC address for the Ethernet interface. I added a
script to the base VM in <span style="font-family:courier
new;">/usr/local/sbin/changemac</span> to make it easier:  
  
<span style="font-family:courier new;">sudo vi
/usr/local/sbin/changemac</span>  
  
And add:  
  
<span style="font-family:courier new;">#!/bin/sh  
mac=`ifconfig -a | grep "HWaddr" | cut -d " " -f 11`</span>  
<span style="font-family:courier new;">echo "eth0 mac $mac arp 1" >
/etc/<span class="blsp-spelling-error"
id="SPELLING_ERROR_0">iftab</span></span>  
  
Then do:  
  
<span style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_1">sudo</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">chmod</span> u+x /<span
class="blsp-spelling-error" id="SPELLING_ERROR_3">usr</span>/local/<span
class="blsp-spelling-error" id="SPELLING_ERROR_4">sbin</span>/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_5">changemac</span></span>  
  
Note that you're adding the script to the "template" VM, so you'll only
have create the script once for each template you create, not each time
you create a new VM.  
  
Now you can copy the "template" VM. Make sure the "template" <span
class="blsp-spelling-error" id="SPELLING_ERROR_6">VM</span> isn't
running. Log in to the <span class="blsp-spelling-error"
id="SPELLING_ERROR_7">VMWare</span> host, change to the directory where
you have the <span class="blsp-spelling-error"
id="SPELLING_ERROR_8">VMs</span>, and copy the <span
class="blsp-spelling-error" id="SPELLING_ERROR_9">VM</span>:  
  
<span style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_10">cd</span> /<span class="blsp-spelling-error"
id="SPELLING_ERROR_11">usr</span>/local/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_12">vmware</span>/Virtual\\ Machines</span>  
<span style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_13">sudo</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_14">cp</span> -R --preserve=permissions,owner
</span><span style="font-style: italic;font-family:courier
new;">old\_<span class="blsp-spelling-error"
id="SPELLING_ERROR_15">VM</span>\_directory</span><span
style="font-family:courier new;"> </span><span style="font-style:
italic;font-family:courier new;">new\_<span class="blsp-spelling-error"
id="SPELLING_ERROR_16">VM</span>\_directory</span>  
  
Now in the <span class="blsp-spelling-error"
id="SPELLING_ERROR_17">VMWare</span> console:  
<ol><li>Import the new <span class="blsp-spelling-error"
id="SPELLING_ERROR_18">VM</span> and start it.  
</li><li>Log in at the console and run <span style="font-family:courier
new;">/<span class="blsp-spelling-error"
id="SPELLING_ERROR_19">usr</span>/local/<span
class="blsp-spelling-error" id="SPELLING_ERROR_20">sbin</span>/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_21">changemac</span></span>.  
</li><li>Change <span style="font-family:courier new;">/etc/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_22">hostname</span></span>, <span
style="font-family:courier new;">/etc/dhcp3/dhclient.conf</span>, and
<span style="font-family:courier new;">/etc/hosts</span> to have the
host name you want for the new machine.  
</li><li>Reboot.</li></ol>I'm sure you should be able to do this without
a reboot, but I don't know which <span class="blsp-spelling-error"
id="SPELLING_ERROR_23">startup</span> scripts do what needs to be done.
Also, I had some problem with <span style="font-family:courier
new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_24">sudo</span></span> not working after changing
<span style="font-family:courier new;">/etc/hosts</span>.  
  
If you forget to change the host name in <span style="font-family:
courier new;">/etc/dhcp3/dhcient.conf</span> the first time around:  
<ol><li>Change it</li><li>Type <span style="font-family: courier
new;">sudo date</span> and then enter your password. This is just to
make sure that sudo isn't going to prompt you for passwords</li><li>Type
<span style="font-family: courier new;">sudo ifdown eth0 &amp;&amp; sudo
ifup eth0</span></li></ol>The above process will work even if you're on
a remote <span style="font-family: courier new;">ssh</span> session
(e.g. Putty), because the network will go down and up before your
terminal times out.

