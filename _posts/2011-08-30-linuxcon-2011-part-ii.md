---
layout: post
title: Linuxcon 2011 Part II
date: '2011-08-30T20:40:00.000-07:00'
author: Larry Reid
tags:
- Zenoss
- IT Infrastructure
- Cloud
modified_time: '2011-08-30T20:40:07.143-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3012821038541757464
blogger_orig_url: http://technopragmatica.blogspot.com/2011/08/linuxcon-2011-part-ii.html
---

I went to a lot of cloud computing-related talks at [Linuxcon 2011][1].
One of the better ones was by Mark Hinkle of [cloud.com][2].  
  
One of [his slides][3] showed what he considers the five characteristics
of cloud computing. Two important ones for him are self service, and a
measured service. I think those are two useful criteria for
distinguishing between a VMware cluster and a cloud that is distinct
from a VMware cluster.  
  
It was clear listening to all the talks, including Mark's, is the role
of open source in the large clouds. Basically, anyone big is building
their service on the open source cloud stacks. Of course, there are
a number of open source cloud stacks. One of the challenges is to pick
which one to use.  
  
Fortunately, there are serious supporters behind the three main stacks.
Eucalyptus has a company called [Eucalyptus Systems][4] backing it now,
headed up by Marten Mikos of MySQL fame. Cloudstack has
[cloud.com][2] which is part of [Citrix][5]. And the [OpenStack][6]
project is backed by [Rackspace][7] and [NASA][8].  
  
One factor that seems to be important is the hypervisors supported by
the cloud stack. OpenStack supports the most right now.  
  
Something that struck me listening to the talks is that the cloud, like
so much in IT, isn't a slam dunk solution by itself. You need to know
what problem you want to solve, and then figure out how to use the cloud
to solve it, if indeed the cloud is a solution to your problem.  
  
Related to that insight, it's clear that unless you solve the problem of
monitoring your infrastructure with [Zenoss][9] or [Nagios][10], and of
provisioning it with Puppet or the like, then you're not going to see
much benefit from the cloud.



[1]: http://events.linuxfoundation.org/events/linuxcon
[2]: http://cloud.com/
[3]: http://www.slideshare.net/socializedsoftware/linuxcon-2011-crash-course-in-open-source-cloud-computing
[4]: http://www.eucalyptus.com/
[5]: http://citrix.com/
[6]: http://openstack.org/
[7]: http://rackspace.com/
[8]: http://www.nasa.gov/
[9]: http://zenoss.com/
[10]: http://nagios.org/
