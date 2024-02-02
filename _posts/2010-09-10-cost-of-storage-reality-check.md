---
layout: post
title: 'The Cost of Storage: Reality Check'
date: '2010-09-10T18:52:00.000-07:00'
author: Larry Reid
tags:
- IT Infrastructure
- SAN
- Cloud
modified_time: '2010-12-27T09:24:20.261-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3162956575971856592
blogger_orig_url: http://technopragmatica.blogspot.com/2010/09/cost-of-storage-reality-check.html
---

A friend pointed me at this awesome blog post from Backblaze, who sell
cloud storage: [Petabytes on a budget: How to build cheap cloud storage
\| Backblaze Blog][1]. They build their own storage boxes based on a
commodity motherboard running Linux, and standard open source software. 

  
Backblaze gets a cost per gigabyte of under $0.12. Yes, 12 cents per GB.
And that's per GB of RAID 6 storage. It's easy to find storage costing
$12 or more per GB from the mainstream storage vendors -- two orders of
magnitude more. The blog post also compares prices of storage. They show
a price difference of up to 2,000 times!  
  
I think there are a lot of areas of IT that a fundamentally broken.
Storage is an area that is most obviously broken, and these price
differences should make that obvious.  
  
What I find really interesting is Backblaze's approach. They published
their hardware design in the blog post. They've open-sourced their
hardware. The supplier of their cabinet is already offering the cabinet
as a product because they've had so much demand. People are buying and
building these boxes, and I'm sure it won't be long before lots of open
source software becomes available that provides storage *solutions*
based on this hardware.  
  
This gives hope. In ten years, perhaps, open source will do to storage
what it's doing to CPU cycles and the operating system business -- get
rid of the artificial cost imposed by proprietary vendors who hoard
technology.



[1]: http://blog.backblaze.com/2009/09/01/petabytes-on-a-budget-how-to-build-cheap-cloud-storage/
