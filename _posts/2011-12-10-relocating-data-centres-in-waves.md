---
layout: post
title: Relocating Data Centres in Waves
date: '2011-12-10T08:11:00.001-08:00'
author: Larry Reid
tags:
- Relocation
modified_time: '2011-12-21T08:50:22.737-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-9033962201737735982
blogger_orig_url: http://technopragmatica.blogspot.com/2011/12/relocating-data-centres-in-waves.html
---

I've never had to relocate a data centre in one big bang. You hear
stories about organizations that shut down all the computers at 5:00 PM,
unplug them, move them, and have them up by 8:00 AM the next morning,
but I've never done that.  
  
The big bang approach may still be necessary sometimes, but you can
mitigate a lot of risk by taking a staged approach, moving a few systems
at a time.  
  
Conventional wisdom on the staged data centre relocation is to move
simpler systems, and test and development systems, first. This lets you
tune your relocation processes and, particularly if you're moving into a
brand new data centre, work the kinks out of the new data centre.  
  
It sounds great in theory. In practice, we ran into a few wrinkles.  
  
I'd say the root source of the wrinkles traces back to our environment:
We had a lot of applications integrated through various tools, and a
large J2EE platform running a lot of custom applications. Also, even
though we had some months to do the relocation in waves, we didn't have
an infinite amount of time. On top of that, business cycles meant that
some systems had to be moved at certain times within the overall
relocation period.  
  
The net result is that we ended up moving some of the most complicated
systems first. At least we were only moving the development and test
environments. Even so, it turned out to be quite a challenge. We were
slammed with a large workload when people were just learning the
processes for shipping and installing equipment in the new data centre.
The team pulled it off quite well, but it certainly increased the stress
level.  
  
I don't think there's much you can do about this. If your time lines
force you to move complicated systems first, so be it. The lesson I take
away is to identify early in planning if I have to move any complicated
environments. On this project, I heard people right from the start
talking about certain environments, and they turned out to be the
challenging ones. We focused on them early, and everything worked out
well.

