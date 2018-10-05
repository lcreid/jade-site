---
layout: post
title: Enterprise Challenges to Continuous Delivery
date: '2016-08-28T21:47:00.001-07:00'
author: Larry Reid
tags:
modified_time: '2016-08-28T21:47:09.724-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1384026818506883962
blogger_orig_url: http://technopragmatica.blogspot.com/2016/08/enterprise-challenges-to-continuous.html
---

On one of my recent projects I noticed a challenge to a [continuous delivery](https://en.wikipedia.org/wiki/Continuous_delivery) (CD) approach in the enterprise that I haven't seen mentioned: Software that requires a paid license.

Most CD approaches are based on easily creating instances of a virtual machine. Software with a paid license often has mechanisms, like the MAC address of the first network interface has to be registered with the software vendor's license server, to prevent automatically creating multiple instances of a virtual machine. Or it may have a license compliance tool that will get very confused by instances of virtual machines appearing and disappearing rapidly.

It's probably not impossible to do CD with your paid software. Obviously, the easiest way to deal with the problem is to use software that's completely free to use. If you can't do that, you'll need to understand how the license restrictions work, and then tailor the continuous deployment approach around those restrictions. Not easy, but probably doable.
