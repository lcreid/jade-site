---
layout: post
title: MySQL From Remote Host
date: '2008-04-21T19:00:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- MySQL
modified_time: '2008-11-06T11:43:04.679-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8303757847383868695
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/mysql-from-remote-host.html
---

I couldn't get MySQL Administrator on a Windows XP desktop to connect to
a MySQL instance I had running on an <span class="blsp-spelling-error"
id="SPELLING_ERROR_0">Ubuntu</span> 6.06 server that I built as a LAMP
server. I was getting:  
<span style="font-family:courier new;" /><blockquote><span
style="font-family:courier new;">Could not connect to the specified
instance.</span>  
  
<span style="font-family:courier new;">MySQL Error Number 2003</span>  
<span style="font-family:courier new;">Can't connect to MySQL server on
'server' (10061)</span>  
</blockquote>I had to edit <span style="font-family:courier
new;">/etc/my.<span class="blsp-spelling-error"
id="SPELLING_ERROR_1">cnf</span></span> (or <span style="font-family:
courier new;">/etc/mysql/my.cnf</span> depending on where yours is
stored) on the <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">Ubuntu</span> server to comment out the
"bind-address" line, then restart the server. I also had to add a
non-root user with all privileges. In fact, you have to add two users as
described [here][1]:  
<span style="font-family:courier new;" /><blockquote><span
style="font-family:courier new;">use <span class="blsp-spelling-error"
id="SPELLING_ERROR_3">mysql</span></span>  
<span style="font-family:courier new;">grant all privileges on *.* to
'<span style="font-style: italic;">user</span>'@'localhost' identified
by '<span style="font-style: italic;">password</span>' with grant
option;</span>  
<span style="font-family:courier new;">grant all privileges on *.* to
'<span style="font-style: italic;">user</span>'@'%' identified by '<span
style="font-style: italic;">password</span>' with grant option;</span>  
<span style="font-family:courier new;">flush privileges</span>;  
</blockquote>There are some posts that show how to enable remote <span
class="blsp-spelling-error" id="SPELLING_ERROR_4">logins</span> by the
MySQL "root" user, but I prefer not to do it that way.



[1]: http://dev.mysql.com/doc/refman/5.0/en/adding-users.html
