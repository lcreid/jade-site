---
layout: post
title: Securing Healthcare Data with MySQL
date: '2009-03-03T16:10:00.000-08:00'
author: Larry Reid
tags:
- Healthcare IT
modified_time: '2009-03-03T16:18:55.506-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-935574805394219833
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/securing-healthcare-data-with-mysql.html
---

As a follow-up to an earlier [post][1], I should mention that part of
the reason I had healthcare data on my personal laptop was to do some
data analysis with MySQL. Between MySQL and the command line tools, it
was very easy for me to load data from other sources and run queries to
monitor or predict the amount of medication we were packaging.  
  
When I was done doing the data analysis, I wanted to scrub the data off
my hard drive. On the version of MySQL that was installed via Synaptic
on Ubuntu 8.10, the default database engine was MyISAM. When a table is
dropped, it deletes the MyISAM file. No need to worry about deleted
records retaining data in a "tablespace" file that one might have to
worry about in other RDBMSs.  
  
Then all I had to do was scrub the hard drive as I described in my
earlier [post][1].



[1]: http://technopragmatica.blogspot.com/2009/02/securing-healthcare-data-with-ubuntu.html
