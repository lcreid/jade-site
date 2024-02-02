---
layout: post
title: 'Bacula: Backups'
date: '2008-04-09T06:02:00.000-07:00'
author: Larry Reid
tags:
- Backups
- IT Infrastructure
- Bacula
modified_time: '2009-03-23T14:50:50.013-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2894414114566985183
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/bacula-backups.html
---

To install <span style="font-family:courier new;">bacula</span> on
Ubuntu, you need to add the universe repositories to <span
style="font-family:courier new;">/etc/apt/sources.list</span>. It's just
a matter of uncommenting four lines:  
<span style="font-family:courier new;" /><pre><span
style="font-family:courier new;">deb
http://ca.archive.ubuntu.com/ubuntu/ dapper universe</span>   
<span style="font-family:courier new;">deb-src
http://ca.archive.ubuntu.com/ubuntu/ dapper universe</span>   
<span style="font-family:courier new;">...</span>   
<span style="font-family:courier new;">deb
http://security.ubuntu.com/ubuntu dapper-security universe</span>   
<span style="font-family:courier new;">deb-src
http://security.ubuntu.com/ubuntu dapper-security universe</span>  
</pre>Then:  
<span style="font-family:courier new;" /><blockquote><span
style="font-family:courier new;">sudo apt-get update</span><span
style="font-family:courier new;" />  
</blockquote>The standard install of <span style="font-family:courier
new;">bacula</span> uses <span style="font-family:courier
new;">sqllite</span>, which the <span style="font-family:courier
new;">bacula</span> guy reports as having problems...

