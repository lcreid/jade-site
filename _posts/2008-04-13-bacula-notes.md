---
layout: post
title: Bacula Notes
date: '2008-04-13T07:01:00.000-07:00'
author: Larry Reid
tags:
- Backups
- Ubuntu
- Bacula
modified_time: '2008-04-13T07:55:03.391-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7162776296325190750
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/bacula-notes.html
---

The [Bacula documentation][1] is good, but given the complex and
interdependent nature of the backup problem, it's pretty overwhelming at
first.  
  
One thing that's not immediately obvious is where the configuration
files are. The <span style="font-family: courier
new;">bacula-fd.conf</span> file for Windows XP clients is at <span
style="font-family: courier new;">C:\\Documents and Settings\\All
Users\\bacula\\bacula-fd.conf</span>. On Ubuntu using the packages
installed from universe, the configuration files are in <span
style="font-family: courier new;">/etc/bacula</span>.  
  
If you get errors that the server can't connect to the client, make sure
the director definition in the client's <span style="font-family:
courier new;">bacula-fd.conf</span> allows the director to connect, and
that the client's password matches the server's password in the client
resource of <span style="font-family: courier
new;">/etc/bacula/bacula-dir.conf</span>. There's a [helpful picture][2]
of what you need to do in the Bacula documentation.



[1]: http://www.bacula.org/en/rel-manual/Bacula_Users_Guide.html
[2]: http://www.bacula.org/en/rel-manual/Bacula_Freque_Asked_Questi.html#SECTION003760000000000000000
