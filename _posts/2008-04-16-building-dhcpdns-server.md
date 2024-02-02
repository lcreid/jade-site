---
layout: post
title: Building A DHCP/DNS Server
date: '2008-04-16T18:04:00.001-07:00'
author: Larry Reid
tags:
- named
- dns
- bind
- Ubuntu
- dhcp
modified_time: '2008-07-25T20:39:11.221-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-271640880627080757
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/building-dhcpdns-server.html
---

Months ago I built a DHCP/DNS server from scratch. Most of these notes I
made at the time I was building it, meaning to fix them up within a day
or two and post them. Of course, I kept doing other things before
finishing the documentation, so here are my rather raw notes. This was
for Ubuntu 6.06 running on VMWare Server.  
<ol><li>Create a new VM with a 2 GB disk, don't preallocate and make
sure all disks are less than 2 GB. Only give it 64 MB of
RAM</li><li>Attach the Ubuntu .iso to the CD and start the
VM</li><li>Build with the options you want</li><li>Do the following:  
</li>  
<blockquote><span style="font-family:courier new;">sudo apt-get
update</span>  
<span style="font-family:courier new;">sudo apt-get upgrade</span>  
<span style="font-family:courier new;">sudo apt-get install ssh
ntp-simple snmpd snmp bacula-client build-essential
linux-headers-$(uname -r)</span></blockquote>  
<li>Install VMTools</li><blockquote style=\"font-family: courier
new;\">cd /tmp  
sudo mount /cdrom  
sudo tar xvfz /cdrom/VMwareTools-1.0.0-27828.tar.gz  
cd vmware-tools-distrib  
sudo ./vmware-install.pl</blockquote>  
<li>Edit <span style="font-family:courier
new;">/etc/dhcp3/dhclient.conf</span> to <span
style="font-family:courier new;">send host-name "netres01";</span>  
</li><li>Restart the network to get into DNS and DHCP (if you already
have one)  
</li><li>Install DHCP and DNS and stop the services:</li><span
style="font-family:courier new;" /><blockquote><span
style="font-family:courier new;">sudo apt-get install dhcp3-server
bind9</span> <span style="font-family:courier new;">sudo  
/etc/init.d/bind9 stop</span> <span style="font-family:courier
new;">sudo /etc/init.d/dhcp3 stop</span></blockquote>  
<li>Since this is a DNS server, I'll allow it to use a fixed IP address.
Edit /etc/network/interfaces. Edit the forward and reverse zone files.  
</li></ol><blockquote>auto eth0  
iface eth0 inet static  
 address 10.3.3.2  
 netmask 255.255.255.0  
 network 10.3.3.0  
 broadcast 10.3.3.255  
 gateway 10.3.3.3  
 pre-up iptables-restore < /etc/iptables.rules post-down iptables-save
-c > /etc/iptables.rules  
</blockquote>You have to kill the existing <span style="font-family:
courier new;">dhclient</span> process because <span style="font-family:
courier new;">ifdown</span>/<span style="font-family: courier
new;">ifup</span> doesn't (it wouldn't know how, really).  
  
Change the key for the DNS server before starting it, or you'll have to
manually look up the pids and kill the <span style="font-family: courier
new;">named</span> processes. <span style="font-family: courier
new;">rndc</span> stops working because the key has changed since <span
style="font-family: courier new;">named</span> started.  
  
If you had a name server from DNS before, it will still be in <span
style="font-family: courier new;">/etc/resolv.conf</span>.  
  
The biggest thing is to get the permissions right on the <span
style="font-family: courier new;">/etc/bind</span> directories and
files.  
  
<span style="font-family: courier new;">nsupdate</span>  
  
Set up the new DNS first and get it working.

