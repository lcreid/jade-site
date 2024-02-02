---
layout: post
title: 'Virtualization: There''s Gotta be a Catch'
date: '2007-04-27T15:01:00.000-07:00'
author: Larry Reid
tags:
- Backups
- VMWare
- Virtualization
- Restores
modified_time: '2007-05-11T09:41:21.932-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6433186037364300910
blogger_orig_url: http://technopragmatica.blogspot.com/2007/04/virtualization-theres-gotta-be-catch.html
---

<span class="blsp-spelling-error"
id="SPELLING_ERROR_0">Virtualization</span> solves lots of problems for
many if not most organizations that have more than a rack of servers. On
an earlier assignment I calculated a worst-case saving of C$380 per
month for a virtual server over a physical server (using <span
class="blsp-spelling-error" id="SPELLING_ERROR_1">ESX</span> 2.5 and 3.0
from <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">VMWare</span>). But there's a catch to <span
class="blsp-spelling-error" id="SPELLING_ERROR_3">virtualization</span>,
and that catch is backups.  
  
<span class="blsp-spelling-error"
id="SPELLING_ERROR_4">Virtualization</span> introduces wrinkles on your
backup approach. Fortunately, to start off you're probably okay doing
your backups the same way you always have been. The backup wrinkles are
not enough to stop you from embarking on <span
class="blsp-spelling-error" id="SPELLING_ERROR_5">virtualization</span>.

  
Here are some of the things you need to watch for as you add virtual
machines (<span class="blsp-spelling-error"
id="SPELLING_ERROR_6">VMs</span>) to your <span
class="blsp-spelling-error" id="SPELLING_ERROR_7">virtualization</span>
platform:  
<ul><li>Do you have highly-tuned start and stop times for your backup
jobs, for example when you have inter-dependencies between external
events and your backup jobs? </li><li>Do the servers you plan to <span
class="blsp-spelling-error" id="SPELLING_ERROR_8">virtualize</span> have
file server-like data, in other words, does it consist of a lot of small
files that mostly don't change?  
</li><li>If you had a fire in your data centre today, before <span
class="blsp-spelling-error" id="SPELLING_ERROR_9">virtualizing</span>,
how soon would you have to have all the servers rebuilt?</li><li>Is your
backup infrastructure really only being used to half capacity or
less?</li></ul>If you have highly tuned backup schedules, you need to
consider how <span class="blsp-spelling-error"
id="SPELLING_ERROR_10">virtualization</span> may mess up those
schedules. Your backup performance may actually improve early on. This
happens when you <span class="blsp-spelling-error"
id="SPELLING_ERROR_11">virtualize</span> a lot of old servers that have
slow disks and/or network cards. Your <span class="blsp-spelling-error"
id="SPELLING_ERROR_12">virtualization</span> platform probably has <span
class="blsp-spelling-error" id="SPELLING_ERROR_13">gigabit</span>
network and may be attached to fast disk (e.g. a fibre channel SAN). The
solution is simple: watch your backup jobs as you <span
class="blsp-spelling-error" id="SPELLING_ERROR_14">virtualize</span>
physical servers and make adjustments as needed.  
  
As you add <span class="blsp-spelling-error"
id="SPELLING_ERROR_15">VMs</span> to your infrastructure, you may run
into decreasing backup performance. The reason: many servers today are
at their busiest during their backup. You may be able to run 20 <span
class="blsp-spelling-error" id="SPELLING_ERROR_16">VMs</span>
comfortably on one physical server, but if you try to back up all those
<span class="blsp-spelling-error" id="SPELLING_ERROR_17">VMs</span> at
once you'll run into bottlenecks because the physical server has a
certain number of network interfaces, and all the data is coming from
the same storage device, or at least through the same storage interface.
Again, the solution is to watch backup performance as you <span
class="blsp-spelling-error" id="SPELLING_ERROR_18">virtualize</span> and
make adjustments.  
  
Be aware that you might have to make changes to your backup
infrastructure to deal with real challenges of backup performance
introduced by <span class="blsp-spelling-error"
id="SPELLING_ERROR_19">virtualization</span>. If your backups are
already a problem, you might want to look into this in more detail. (The
problems and solutions are beyond the scope of this post.)  
  
How long do you have to rebuild servers after a data centre fire? You
may not have even thought of the problem (don't be embarrassed. Many of
us haven't). With <span class="blsp-spelling-error"
id="SPELLING_ERROR_20">virtualization</span> you have to think about it
because an equivalent event is more likely to happen: The storage device
that holds all your <span class="blsp-spelling-error"
id="SPELLING_ERROR_21">VMs</span> may lose its data, and you're faced
with rebuilding all your <span class="blsp-spelling-error"
id="SPELLING_ERROR_22">VMs</span>. I have second-hand experience (e.g.
the guys down the street) with storage devices eating all the <span
class="blsp-spelling-error" id="SPELLING_ERROR_23">VMs</span>, but I've
never directly known anyone who had a serious fire in the data centre.  
  
If the backups on your physical servers can be restored to bare metal,
then you don't have to worry about your storage device eating the <span
class="blsp-spelling-error" id="SPELLING_ERROR_24">VMs</span>. You may
have to make some changes to your bare-metal backup -- I have no
experience with that topic so I don't know for sure -- but once you do
you should be able to restore your <span class="blsp-spelling-error"
id="SPELLING_ERROR_25">VMs</span> relatively quickly.  
  
If you can't or don't have backups that can be restored to bare metal,
then you have a challenge. I doubt that most general purpose data
centres are full of identically configured servers, with detailed
rebuild procedures and air-tight configuration management so every
server can be rebuilt exactly like the one that was running before. If
you had to rebuild 200 <span class="blsp-spelling-error"
id="SPELLING_ERROR_26">VMs</span> from installation disks, you'd
probably be working a lot of long nights.  
  
If most of your servers that you plan to <span
class="blsp-spelling-error" id="SPELLING_ERROR_27">virtualize</span>
have database-like data (large files that change every day), I'd
recommend looking at changing your backup approach for those servers to
a product like <span class="blsp-spelling-error"
id="SPELLING_ERROR_28">ESX</span> Ranger, or look for some of the
user-built solutions on the Internet. These products will back up the
entire virtual machine every time they run, and may not allow individual
file (within the <span class="blsp-spelling-error"
id="SPELLING_ERROR_29">VM</span>) restores. However, for a database
server you're probably backing up the whole server every night anyway,
so that won't be a significant change to your backup workload.  
  
If you want to <span class="blsp-spelling-error"
id="SPELLING_ERROR_30">virtualize</span> file server-like servers, there
isn't really a good solution that I or anyone I know has found at this
time. If your backup infrastructure has enough room to take the
additional load, simply back up with <span class="blsp-spelling-error"
id="SPELLING_ERROR_31">ESX</span> Ranger or one of the other solutions
once a week (or however frequently you do a full backup), along with
your current full and incremental backup schedule. If you have to
rebuild the <span class="blsp-spelling-error"
id="SPELLING_ERROR_32">VM</span>, you restore the most recent <span
class="blsp-spelling-error" id="SPELLING_ERROR_33">ESX</span> Ranger
backup first. If you just have to restore files on the server, because a
user deleted an important document, for example, just use the regular
backups.  
  
If you have the budget to change backup infrastructures, <span
class="blsp-spelling-error" id="SPELLING_ERROR_34">ESX</span> Ranger can
probably provide a pretty good overall solution. However, you have to
provide backup and restore for physical servers as well, so the staff
who do restores have to be able to deal with two backup systems.  
  
One final gotcha that I've run across: There are some great devices out
there from companies like Data Domain that provide excellent compression
of exactly the type of data you're backing up when you back up an entire
<span class="blsp-spelling-error" id="SPELLING_ERROR_35">VM</span>.
Unfortunately, <span class="blsp-spelling-error"
id="SPELLING_ERROR_36">ESX</span> Ranger compresses the data too, which
messes up the storage device's compression. Whatever solution you put
together, make sure your vendor commits to performance targets based on
the entire solution, not on individual products.  
  
As with so much of what we do in IT, it's really hard to summarize
everything in a way that makes sense in a blog post. Comment on this
post if you'd like more details or reasons why I make the
recommendations I make.

