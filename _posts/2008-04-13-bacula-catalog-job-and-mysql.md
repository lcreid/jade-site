---
layout: post
title: Bacula Catalog Job and MySQL
date: '2008-04-13T19:31:00.000-07:00'
author: Larry Reid
tags:
- Backups
- MySQL
- Bacula
modified_time: '2008-04-13T19:38:12.342-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3852536745549265637
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/bacula-catalog-job-and-mysql.html
---

To make the Bacula catalog job work:  
<ol><li>Edit <span style="font-family: courier
new;">/etc/bacula/bacula-dir.conf</span> on the backup
server</li><li>Change where it says <span style="font-family: courier
new;">-u<user> -p<password></span> to <span style="font-family: courier
new;">-u bacula</span></li><li>Edit <span style="font-family: courier
new;">~bacula/.my.cnf</span> and put this:</li></ol><blockquote
style="font-family: courier new;">[client]  
password=<span style="font-style:
italic;">your_secret_password</span></blockquote><ol style="font-family:
courier new;"><li value="4">chmod 400 ~bacula/.my.cnf ; chown
bacula:bacula ~bacula/.my.cnf</li></ol>Now it should work. Don't forget
to do "reload" in <span style="font-family: courier
new;">bconsole</span>.</password></user>
</span>

