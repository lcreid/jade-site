---
layout: post
title: Installing Bacula
date: '2008-04-09T20:02:00.000-07:00'
author: Larry Reid
tags:
- Backups
- IT Infrastructure
- Bacula
modified_time: '2009-03-23T15:07:01.887-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1089402684957365455
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/installing-bacula.html
---

To install bacula with MySQL (after you do [this][1]):  
  
<span style="font-family:courier new;">sudo apt-get install mysql-server
bacula-director-mysql</span>  
  
Then you have to set up <span style="font-family:courier
new;">exim4</span>, the mail system. Choose:  
  
<span style="font-family:courier new;">mail sent by smarthost; no local
mail</span>  
  
After you install the MySQL version of the bacula director, you can
install the rest of bacula this way, and also install some recommended
packages:  
  
<span style="font-family:courier new;">sudo apt-get install bacula  
sudo apt-get install dds2tar scsitools sg3-utils  
</span>  
I had these notes from an earlier set-up of <span
style="font-family:courier new;">exim4</span>:  
<blockquote></blockquote><blockquote>Look into setting up <span
style="font-family:courier new;">/etc/aliases</span> later to redirect
mail to more useful places. Also, make sure the domain of the outgoing
address is one known to the outside world (e.g. <span
style="font-family:courier new;">jadesystems.ca</span>) or the SMTP
server will probably reject the message.</blockquote>



[1]: http://technopragmatica.blogspot.com/2008/04/bacula-backups.html
