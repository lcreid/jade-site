---
layout: post
title: A New Computer -- Backups
date: '2011-10-27T20:42:00.000-07:00'
author: Larry Reid
tags:
- Backups
- Ubuntu
- New Computer
- Bacula
modified_time: '2011-10-27T20:42:26.963-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3592270586136704507
blogger_orig_url: http://technopragmatica.blogspot.com/2011/10/new-computer-backups.html
---

I'd love to find a new backup solution, but the reality is I have Bacula
working reasonably consistently right now, and it's the easiest thing to
get set up quickly. So I:  
<ol><li>Installed bacula-client and bacula-traymonitor packages (sudo
apt-get install bacula-client bacula-traymonitor)</li><li>Copied
/etc/bacula/bacula-fd.conf and /etc/bacula/tray-monitor.conf from the
old laptop</li><li>Changed the host name in both the above
files</li><li>Added my new laptop to /etc/bacula/bacula-dir.conf on the
bacula director host by copying the job definition of the old laptop and
renaming it</li></ol>

