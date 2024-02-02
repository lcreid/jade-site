---
layout: post
title: Can't Run VMWare Server 2 Management Interface
date: '2010-07-18T10:03:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Virtualization
modified_time: '2010-07-28T08:33:28.869-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3573181399069343334
blogger_orig_url: http://technopragmatica.blogspot.com/2010/07/cant-run-vmware-server-2-management.html
---

| I filled the disk on my VMWare Server 2 host, which caused all sorts of grief. Part of the grief was that I couldn't get to the management interface at https://vmhost:8333/ui. I solved that problem by killing the VMWare hostd process (after freeing up some space on the disk):   
<ol><li>Look up the process ID: ps -ea | grep hostd</li><li>Kill the process: sudo kill *pid* </li><li>Remove the old lock file: sudo rm /var/run/vmware/vmware-hostd.PID</li><li>Restart VMWare management: sudo /etc/init.d/vmware-mgmt restart </li></ol> |

