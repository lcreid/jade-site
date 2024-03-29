---
layout: post
title: The Real World is a Surprising Place
date: '2007-04-25T16:25:00.000-07:00'
author: Larry Reid
tags:
- Disk Array
- SAN
modified_time: '2007-05-11T09:42:03.005-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-988964406369398179
blogger_orig_url: http://technopragmatica.blogspot.com/2007/04/real-world-is-surprising-place.html
---

Some recent [real-world research][1] (and [commentary][2]) shows that
the quality and price of a disk drive has far less impact on its
lifespan than conventional wisdom would have it to be. SCSI, Fibre
Channel and <span class="blsp-spelling-error"
id="SPELLING_ERROR_0">SATA</span> disks all fail at roughly the same
rate. And the [<span class="blsp-spelling-error"
id="SPELLING_ERROR_1">MTBF</span>][3] that many manufacturers claim for
their drives is not supported in the study, either.  
  
The findings of the paper lead to some very significant considerations
for the IT manager:  
<ul><li>You need to pay the overhead for a RAID level that can survive a
disk failure while the disk array is rebuilding itself after an earlier
disk failure. <span style="font-style: italic;">RAID 5 isn't good
enough.</span> The study found that disk failures are not random, and
that if a disk fails in one of your disk arrays, there's a good chance
that another disk will soon fail in the same disk array. <span
class="blsp-spelling-error" id="SPELLING_ERROR_2">NetApp</span>, for
example, addresses this problem, but it means that 7 TB of raw disk
space turns into about 4.9 TB of usable disk space (at least for a <span
class="blsp-spelling-error" id="SPELLING_ERROR_3">FAS</span> 3020).
That's 70 percent usable.  
</li><li>Plan for disk failures during the entire lifetime of your
storage devices. Disks fail far more often than the manufacturer's data
would suggest, and they also fail much like any other mechanical device:
the longer they've been on, the more likely they are to fail. You can't
assume that a four-year refresh cycle will keep you free of disk
failures. The idea that disks either fail in the first few months or
after several years of use is <span style="font-style:
italic;">not</span> supported by real world observations.  
</li><li>Don't believe everything your vendor, or conventional wisdom,
tells you. This isn't a recommendation of the paper, by the way, but to
me it's such an obvious conclusion that it needs to be said. It's also
so obvious that I'm sure you're thinking, "Well, yeah." However, not
believing your vendor is a pretty significant thing to actually commit
to. Most IT managers don't have the luxury of testing everything their
vendors tell them. The topic is big enough to merit a post of its own.
(Interestingly, a staggering number of the comments to Robin Harris'
[commentary][2] on the paper were along the lines of "the results of the
paper must be wrong because everyone knows blah, blah, blah." Never
underestimate the power of religion, even if that religion is an
adherence to a particular technology.)  
</li></ul>The authors of the paper cite some possible reasons for these
perhaps surprising findings. One of them is that disk life may depend
far more on the conditions the disk operates under rather than the
quality of the disk itself. Desktop disks may fail more often simply
because they tend to be in nastier environments than server disks, which
typically sit in a nice, clean environmentally-controlled data centre.
You may have multiple disk failures in a disk array in the data centre
because the room got a bit warm when you were testing fail-over to the
backup air conditioning units, for example.  
  
A reason cited for more failures in the field than the data sheet would
suggest is that customers may have more stringent test criteria than the
manufacturer. One manufacturer reported that almost half of drives
returned to them had no problem. However, the paper reports failure
rates at least four times the data sheet rates, so that doesn't explain
away the difference between data sheet and observed <span
class="blsp-spelling-error" id="SPELLING_ERROR_4">MTBF</span>.  
  
As an aside, I find it rather interesting that manufacturers of disks
would simply accept that half of the returns are of non-defective
drives. They're implying that their customers are stupid at least half
the time. Perhaps they need to consider how they qualify a disk as being
failed. People don't usually take down critical systems and do hardware
maintenance on a whim. They had a good reason to suspect a drive
failure.  
  
Finally, I think the paper gives some hope that the we might see more
studies based on real world observations. The authors of the paper were
able to collect statistically significant data from a relatively small
number of sites, due in part to the rise of large data centres with lots
of hardware in them. As things like Software as a Service, large <span
class="blsp-spelling-error" id="SPELLING_ERROR_5">ISPs</span>, etc. make
centralized IT infrastructure more common, it may actually become easier
to collect, analyze and publish real world observations about the
performance of IT infrastructure. This would help manufacturers and IT
managers alike.



[1]: http://www.usenix.org/events/fast07/tech/schroeder.html
[2]: http://storagemojo.com/?p=383
[3]: http://en.wikipedia.org/wiki/MTBF
