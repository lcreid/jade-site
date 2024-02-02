---
layout: post
title: Karma and Data Centre Relocations
date: '2011-12-10T07:54:00.001-08:00'
author: Larry Reid
tags:
- Relocation
modified_time: '2011-12-10T08:05:21.881-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6004406211334698201
blogger_orig_url: http://technopragmatica.blogspot.com/2011/12/karma-and-data-centre-relocations.html
---

We're pretty much done the current project: relocation of 600 servers to
a new data centre 400 kms from the old one. By accident more than by
design we left the move of most of the significant Windows file shares
to the last month of the relocation period.  
  
Windows file shares are known to be a potential performance issue when
you move your data centre away from a group of users who are used to
having the file shares close to them. We're no exception: A few
applications have been pulled back to the old data centre temporarily
while we try to find a solution to the performance issues, and we have
complaints from people using some desktop tools that don't work nicely
with latency.  
  
The luck part is that we've  developed lots of good karma by making the
rest of the relocation go well. Now that we have issues, people are
quite tolerant of the situation and are at least willing to let us try
to fix the problems. I won't say they're all happy that we've slowed
their work, but at least we don't have anyone screaming at us.  
  
I'd go so far as to say this should be a rule: All other things equal,
move file shares near the end of a relocation project.

