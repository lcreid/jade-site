---
layout: post
title: Cheap Hosting and PHP Memory
date: '2009-03-03T15:41:00.000-08:00'
author: Larry Reid
tags:
- Drupal
- Collaboration
- PAC
modified_time: '2009-04-17T07:06:38.454-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2113291176507123657
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/cheap-hosting-and-php-memory.html
---

(For an update, read [this post][1].)  
  
I've been working on a few websites: One for my son's school's parent
advisory council (PAC) and one for some community health centres. It
gives me a chance to get to know what's out there in the open source
world for content management, <span class="blsp-spelling-error"
id="SPELLING_ERROR_0">wikis</span>, and other collaboration tools that
we're supposed to be using to make ourselves more effective and
productive.  
  
The first step was to find a hosting provider that let me run <span
class="blsp-spelling-error" id="SPELLING_ERROR_1">PHP</span>, as the
free hosting I get from my <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">ISP</span> is for static pages only. I was
pleasantly surprised to find very cheap hosting with <span
class="blsp-spelling-error" id="SPELLING_ERROR_3">PHP</span>, MySQL and
everything I needed, many for less than C$10 per month. I chose [<span
class="blsp-spelling-error" id="SPELLING_ERROR_4">HostPapa</span>][2] --
despite the somewhat odd name, they seemed to have a good reputation.  
  
There's a catch, it turns out. I'm using [<span
class="blsp-spelling-error" id="SPELLING_ERROR_5">Drupal</span>][3] 6, a
well-established and widely used content management system. When I build
a site with a reasonable set of contributed modules (calendars,
translations, FAQs), it needs more than 32MB of memory in <span
class="blsp-spelling-error" id="SPELLING_ERROR_6">PHP</span> (I get a
white page with a message saying "memory exhausted"). And I'd like to
add a number of other modules.  
  
My hosting provider doesn't let me change the amount of <span
class="blsp-spelling-error" id="SPELLING_ERROR_7">PHP</span> memory, so
the whole hosting arrangement is mostly useless. (There are good
instructions for how to increase the <span class="blsp-spelling-error"
id="SPELLING_ERROR_8">PHP</span> memory in <span
class="blsp-spelling-error" id="SPELLING_ERROR_9">Drupal</span>
[here][4], but not surprisingly the cheap providers don't allow you to
take too much memory.)  
  
I also originally considered using [<span class="blsp-spelling-error"
id="SPELLING_ERROR_10">Joomla</span>!][5]. Once I ran into the problem
with <span class="blsp-spelling-error"
id="SPELLING_ERROR_11">Drupal</span> I did some searching of the
Internet and found that it seems to be an issue with <span
class="blsp-spelling-error" id="SPELLING_ERROR_12">Joomla</span>! as
well. Neither runs comfortably in 32MB if you have a reasonable
selection of add-on modules. (Instructions to increase <span
class="blsp-spelling-error" id="SPELLING_ERROR_13">PHP</span> memory
exist with <span class="blsp-spelling-error"
id="SPELLING_ERROR_14">Joomla</span>! with the same caveat that the
provider can prevent you from doing it.)  
  
It's rather unfortunate. My idea was to have this space to be able to do
proofs of concept or show potential clients what could be done with
modern collaboration tools. It would be likely that any serious customer
would be able to host their own server, or at least pay for a slightly
more expensive hosting provider. I don't need a high volume website, but
I do need a space where I can show the capabilities of the tools. I hate
to have to pay more money on pure speculation that this will lead to
work, but it looks like that's the case.  
  
I don't know whether to be annoyed with the content management systems
for being memory hogs, or the hosting providers for setting unreasonably
low limits on accounts on which they should fully expect people to use a
modern content management system. By the way, I'm not really annoyed at
either. I can see their point of view: HostPapa is really cheap and they
need to control costs somehow, and serious Drupal users will find the
difference of $10 per month for better hosting to be inconsequential, or
will be paying for a dedicated server anyway because they get so much
traffic.  
  
The obvious lesson: One of the big things to look at when evaluating
hosting services is how much <span class="blsp-spelling-error"
id="SPELLING_ERROR_15">PHP</span> memory they give you. It's easy to
offer unlimited database space, unlimited sub-domains, and other such
goodies when you know that no one can use serious website management
tools anyway.



[1]: http://technopragmatica.blogspot.com/2009/03/hosting-websites-part-ii.html
[2]: http://www.hostpapa.ca/
[3]: http://www.drupal.org/
[4]: http://drupal.org/node/207036
[5]: http://www.joomla.org/
