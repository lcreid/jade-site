---
layout: post
title: Unit Dose Roll-Out Part II
date: '2008-09-28T14:01:00.000-07:00'
author: Larry Reid
tags:
- Project Management
- Healthcare IT
- Unit Dose
modified_time: '2010-05-03T21:17:37.418-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6169911650558483582
blogger_orig_url: http://technopragmatica.blogspot.com/2008/09/unit-dose-roll-out-part-ii.html
---

The machines we're using to package the medications are the [FastPak
EXP][1] from [Automed][2] (AmerisourceBergen). They have an awesome
pre-installation support team. The front-end sales people were so-so --
your mileage will vary, of course, depending on the region. The sales
team was Western Canada; the pre-installation support is for all of
Canada.  
  
The machines themselves have a number of quirks. Nothing that can't be
worked around, but don't believe that you won't have to make any
decisions yourself. Also, since we're running three machines, we've
written our own little database scripts to keep the data in the machines
synchronized. There's no way you should try to do it by hand, although I
suspect that's what most people do because the vendor doesn't have
anything to help.  
  
The main competition to Automed are the [Pacmed][3] machines from
[McKesson][4]. There are some differences between the two that will
require a change to your extract or interface from whatever Pharmacy
Information System you're using. Nothing big, but in software even a
small thing can cost a lot of money. It's worth looking into the
interface in detail if you're looking at switching from Pacmed or
running both in parallel.  
  
Because we're packaging all regularly scheduled oral solids (with some
exceptions) we've found that our Pharmacy Information System wasn't
really set up to handle some of the scenarios. Our distribution model
seems to be different from the typical hospital pharmacy, but I don't
have enough experience with hospital pharmacies to say if these
challenges would generalize to other installations.



[1]: http://www.automedrx.com/pages/products.html
[2]: http://www.automedrx.com/
[3]: http://www.mckesson.com/en_us/McKesson.com/For%2BPharmacies/Inpatient/Medication%2BPackaging/PACMED.html
[4]: http://www.mckesson.com/
