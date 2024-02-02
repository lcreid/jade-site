---
layout: post
title: Test Everything - Yeah, Right
date: '2007-05-09T14:58:00.000-07:00'
author: Larry Reid
tags: 
modified_time: '2007-05-09T15:15:23.786-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2286194719249872967
blogger_orig_url: http://technopragmatica.blogspot.com/2007/05/test-everything-yeah-right.html
---

I just read a short article that said the first thing to do to solve a
lot of our IT infrastructure problems is to, "<span class="h3"><span
class="text3">**Create and maintain a test environment that mimics the
production environment.** Also commit to testing every change."
(Emphasis from the original article.)  
  
No problem. Since my 2,000 square foot data centre is already full of
the 450+ physical and virtual servers I have in it, I'll just build
another data centre and buy another 450 servers with all the associated
software support and licensing costs. The lease costs alone on 2,000
square feet around here are about C$40,000 per month. I'm sure most IT
managers have enough spare change in their budget to pull off that one
-- not.  
  
On top of that, you can <span style="font-style: italic;">never</span>
test everything. When I led the <span class="blsp-spelling-error"
id="SPELLING_ERROR_0">virtualization</span> of 135 physical servers, the
<span style="font-style: italic;">only</span> problems we had after
going live with any of the virtual machines were caused by changing
<span class="blsp-spelling-error" id="SPELLING_ERROR_1">IPs</span>
(which we had to do because of the enterprise network design). We
wouldn't have caught those with a test data centre. There are lots of
problems similar to that one lurking in a typical IT infrastructure.  
  
You've got to build flexible infrastructures. Make sure nothing uses
hard-coded <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">IPs</span>. Make sure your <span
class="blsp-spelling-error" id="SPELLING_ERROR_3">DNS</span> doesn't
have legacy pointers hiding in corners that you forget to update. Limit
the partitioning of networks by physical location as much as possible in
the first place. Build commodity server infrastructures.  
  
(P.S. We did have other problems <span class="blsp-spelling-error"
id="SPELLING_ERROR_4">virtualizing</span> the 135, but we found them
before we turned the <span class="blsp-spelling-error"
id="SPELLING_ERROR_5">VMs</span> over to production. The only problems
that were seen by users were <span class="blsp-spelling-error"
id="SPELLING_ERROR_6">IP</span>-change-related.)  
</span></span>

