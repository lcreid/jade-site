---
layout: post
title: Tape Rotation with Bacula
date: '2008-04-21T18:49:00.000-07:00'
author: Larry Reid
tags:
- Backups
- VMWare
- Ubuntu
- Bacula
- Dell
modified_time: '2008-04-21T18:52:43.661-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8496322384818155899
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/tape-rotation-with-bacula.html
---

I love the topic of backups. I say that because it's <span
class="blsp-spelling-error" id="SPELLING_ERROR_0">IT's</span> dirty
secret. No one should keep data in one place only, yet it's very
difficult to set up a backup solution. Different organizations have
different needs, and so backup software has to provide a lot of options.
But the need for options means when you just want to get basic backup
running quickly, it's a challenge.  
  
This post is part of a series about rolling your own backup solution.
There are other ways to do it, but I wanted to do my own solution one
more time...  
  
I'm backing up a Windows <span class="blsp-spelling-error"
id="SPELLING_ERROR_1">XP</span> desktop and a Windows <span
class="blsp-spelling-error" id="SPELLING_ERROR_2">XP</span> laptop, a
Dell SC440 which is the <span class="blsp-spelling-error"
id="SPELLING_ERROR_3">VMWare</span> host, plus a number of Linux <span
class="blsp-spelling-error" id="SPELLING_ERROR_4">VMs</span> that
provide my basic infrastructure: <span class="blsp-spelling-error"
id="SPELLING_ERROR_5">DNS</span>, <span class="blsp-spelling-error"
id="SPELLING_ERROR_6">DHCP</span>, file server, Subversion server, test
platforms for software development, and the backup server itself.  
  
I chose tape in part because I can take the backup off-site. I'll take a
tape off-site once a week. That means I might lose a week's worth of
work if my house burns down, but I'm not ready to invest in the time and
effort to swap tapes every day, either.  
  
The <span class="blsp-spelling-error"
id="SPELLING_ERROR_7">Bacula</span> documentation has a good section on
[backup strategies][1], but none of them include mine. I'll have to
figure it out myself.  
  
<span class="blsp-spelling-error" id="SPELLING_ERROR_8">Bacula</span>
manages tapes in a [tape pool][2]. A pool is just a group of tapes.
(<span class="blsp-spelling-error" id="SPELLING_ERROR_9">Bacula</span>
calls tapes "volumes".) I want to let <span class="blsp-spelling-error"
id="SPELLING_ERROR_10">Bacula</span> fill up one tape per week before it
uses another, which is the default behaviour. At the end of the week, I
want to eject the tape and use another. I'll let <span
class="blsp-spelling-error" id="SPELLING_ERROR_11">Bacula</span>
[automatically recycle][3] the tapes, meaning that after a week (in my
case), <span class="blsp-spelling-error"
id="SPELLING_ERROR_12">Bacula</span> will reuse a tape, overwriting the
old backups on it.  
  
Anyway, I started with a rotation to do a full backup Sunday night,
incremental backups all week, and then eject the tape Saturday night
after the last incremental. With three tapes I would always have last
week's tape off site, except on Sunday.  
  
I really only got started when I realized that that's a lot of tape wear
given that the off-site happens once a week and that I have a fair bit
of disk space on my main server. So my next idea is:  
  
Take a full backup Monday night to disk, and <span
class="blsp-spelling-error" id="SPELLING_ERROR_13">incrementals</span>
up to Sunday night. Then, Monday morning write the whole disk volume to
tape and take it off-site. That way I only run the tape once a week, and
hopefully in a scenario that minimizes the chance of [shoe-shining][4].
I'll write the data to disk without compression, and let hardware
compression compress the data to tape.  
  
This also has the nice property that last week's backups are also on the
disk (if I have enough disk space), so if I need a file I can get it
from disk rather than retrieving the tape.



[1]: http://www.bacula.org/en/rel-manual/Backup_Strategies.html
[2]: http://www.bacula.org/en/rel-manual/Getting_Started_with_Bacula.html#SECTION00920000000000000000
[3]: http://www.bacula.org/en/rel-manual/Automatic_Volume_Recycling.html#RecyclingChapter
[4]: http://en.wikipedia.org/wiki/Tape_drive
