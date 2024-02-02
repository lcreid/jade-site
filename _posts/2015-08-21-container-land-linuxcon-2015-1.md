---
layout: post
title: 'Container Land -- Linuxcon 2015 #1'
date: '2015-08-21T18:50:00.001-07:00'
author: Larry Reid
tags:
- Linux
- Containers
- Linuxcon
- Linuxcon2015
modified_time: '2015-08-21T21:09:56.026-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2237577819698538652
blogger_orig_url: http://technopragmatica.blogspot.com/2015/08/container-land-linuxcon-2015-1.html
---

I went to [Linuxcon 2015 NA][1]{: target="_blank"} with a [friend][2]{:
target="_blank"} this year. It wasn't hard to figure out what the
flavour of the year was -- containers. And [Docker][3]{:
target="_blank"} was the overwhelming favourite. As usual, I found it
way easier to see the negative in the hype, rather than the positive.  
  
But I'll try to see the positive first. There's a lot of value in having
a thinner layer, thinner than a full virtual machine, between an
application's context and the bare metal. There's also value in
packaging an application and distributing it in a way that's thinner
than shipping a whole virtual machine. Containers have the potential to
provide these features.  
  
The container has many historical roots, but from what I saw, we're
mostly excited today because this is what Google has been using for 10
years to run their vast server farms. They have a very particular use
case: Huge numbers of users accessing a small set of relatively
homogeneous functionality. Perfect for a light-weight way of deploying a
huge number of instances of applications across the smallest number of
physical resources possible.  
  
There were a number of presentation where the engineering challenges
around containers were discussed. And there are significant ones,
primarily around networking and privileges (all processes in containers
run as root on the containing physical machine). These challenges will
be solved, but not for another 18-24 months, I'd guess. Only then can we
start to talk about adoption in the enterprise world.  
  
In the enterprise world, the one I get paid to play in, we're mostly
still dealing with servers as [pets][4]{: target="_blank"}. Even at my
current client, who have drunk the DevOps kool-aid and have Puppetized a
lot of their deploys, we're talking about very few duplicate instances
of a server in production. (They get value from [Puppet][5]{:
target="_blank"} by cleverly factoring the Puppet configuration across
development, test, UAT, and production environments.)  
  
Given the engineering effort that was evident in the containers model, I
think there's going to be another significant adoption hill, like there
was for virtualization. Perhaps even more so, as I'm not convinced that
the math will be quite as compelling for containers as it was for VMs.
The problem is that the definitions of containers have to be
hand-crafted. Once the container is defined, you can spin up thousands,
quickly and efficiently. But as I just said, most enterprises just need
a few instances of any particular application.  
  
Some of the speakers talked about containers being just another stop on
the continuum from physical machines to virtual machines and other
models ([Amazon Lambdas][6]{: target="_blank"}, for example). SaaS (not
PaaS) providers can use containers to realize savings on hardware,
because they can amortize the container definition cost over all their
customers. Enterprises that use SaaS will use containers, without even
knowing it, as it should be.  
  
Compounding the problem of enterprise adoption of containers in-house,
is the fact that the orchestration tools (tools for spinning up,
shutting down, and monitoring a large number of instances), are largely
split along the underlying model: You use [VMware][7]{: target="_blank"}
or [Openstack][8]{: target="_blank"} to manage virtual machines, and
[Kubernetes][9]{: target="_blank"} (or any one of hundreds of other
offerings) to manage containers. Most enterprises won't have the
personnel or the volume of applications to justify developing two
different skill sets and platforms to manage their VMs and containers.
There needs to be a unified orchestration platform that covers the
spectrum of deployment models.  
  
In summary, I think that containers will be a significant deployment
option in the near future, but the way they will be used in practice is
still to be determined, and they may never end up being adopted for
in-house enterprise deployments.



[1]: http://events.linuxfoundation.org/events/linuxcon-north-america
[2]: http://thesoftwarelife.blogspot.ca/
[3]: https://www.docker.com/
[4]: https://www.google.ca/webhp?sourceid=chrome-instant&amp;ion=1&amp;espv=2&amp;ie=UTF-8#q=puppies%20pets%20vs.%20cattle
[5]: http://puppetlabs.com/
[6]: https://aws.amazon.com/lambda/
[7]: http://vmware.com/
[8]: http://openstack.org/
[9]: http://kubernetes.io/
