---
layout: post
title: VMWare Server on Ubuntu 6.06.1
date: '2008-03-24T08:13:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Virtualization
- Ubuntu
- IT Infrastructure
modified_time: '2008-03-24T08:17:38.622-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1382860483590076627
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/vmware-server-on-ubuntu-6061.html
---

The install went smoothly. I created a user "<span
class="blsp-spelling-error" id="SPELLING_ERROR_0">vmware</span>" and
added it to the admin group. Then I had to:  
  
<span style="font-family: courier new;"><span
class="blsp-spelling-error" id="SPELLING_ERROR_1">sudo</span> apt-get
install <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">xinetd</span></span>  
<span style="font-family: courier new;"><span
class="blsp-spelling-error" id="SPELLING_ERROR_3">sudo</span> apt-get
install <span class="blsp-spelling-error"
id="SPELLING_ERROR_4">libx</span>11-6 <span class="blsp-spelling-error"
id="SPELLING_ERROR_5">libx</span>11-<span class="blsp-spelling-error"
id="SPELLING_ERROR_6">dev</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_7">libxtst</span>6 <span class="blsp-spelling-error"
id="SPELLING_ERROR_8">xlibs</span>-<span class="blsp-spelling-error"
id="SPELLING_ERROR_9">dev</span></span>  
  
The last line was thanks to [this post][1]. Without it, it wouldn't
validate my serial number (and I'm sure I would have run into other
problems).  
  
The only default I changed was to put my virtual machines in <span
style="font-family: courier new;">/<span class="blsp-spelling-error"
id="SPELLING_ERROR_10">usr</span>/local/<span
class="blsp-spelling-error" id="SPELLING_ERROR_11">vmware</span>/Virtual
Machines</span>, because <span style="font-family: courier new;">/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_12">usr</span>/local</span> is the big partition I
made for <span class="blsp-spelling-error"
id="SPELLING_ERROR_13">VMs</span>.



[1]: http://www.bluejazzconsulting.com/2007/03/10/tips-for-installing-vmware-server-on-ubuntu-edgy-610/
