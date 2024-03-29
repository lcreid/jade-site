---
layout: post
title: Installing the Xen Guest Agent on an Ubuntu VM
date: '2008-03-18T05:43:00.000-07:00'
author: Larry Reid
tags:
- Virtualization
- IT Infrastructure
- Xen
modified_time: '2008-03-23T07:35:37.931-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6497006055900947773
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/virtual-cddvd-in-ubuntu-vm.html
---

To install the guest agent on an <span class="blsp-spelling-error"
id="SPELLING_ERROR_0">Ubuntu</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_1">VM</span>, I tried:  
<ol><li>Start the <span class="blsp-spelling-error"
id="SPELLING_ERROR_2">Ubuntu</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_3">VM</span> if it isn't already running</li><li>In
<span class="blsp-spelling-error"
id="SPELLING_ERROR_4">XenCenter</span>, select the <span
class="blsp-spelling-error" id="SPELLING_ERROR_5">VM</span> in the left
panel, and select the Console tab in the right panel</li><li>Select
"<span class="blsp-spelling-error"
id="SPELLING_ERROR_6">xs</span>-tools.<span class="blsp-spelling-error"
id="SPELLING_ERROR_7">iso</span>" from the drop down list just above the
console window</li><li>Click on the console window, log in if necessary,
and type <span style="font-family:courier new;"><span
class="blsp-spelling-error" id="SPELLING_ERROR_8">sudo</span> mount
/<span class="blsp-spelling-error"
id="SPELLING_ERROR_9">dev</span>/<span class="blsp-spelling-error"
id="SPELLING_ERROR_10">hdd</span> /<span class="blsp-spelling-error"
id="SPELLING_ERROR_11">mnt</span></span></li></ol>So in other words,
where the <span class="blsp-spelling-error"
id="SPELLING_ERROR_12">Xen</span> documentation says <span
style="font-family:courier new;">/<span class="blsp-spelling-error"
id="SPELLING_ERROR_13">dev</span>/<span class="blsp-spelling-error"
id="SPELLING_ERROR_14">xvdd</span></span>, use <span
style="font-family:courier new;">/<span class="blsp-spelling-error"
id="SPELLING_ERROR_15">dev</span>/<span class="blsp-spelling-error"
id="SPELLING_ERROR_16">hdd</span></span> on <span
class="blsp-spelling-error" id="SPELLING_ERROR_17">Ubuntu</span>.  
  
If you just type <span class="blsp-spelling-error"
id="SPELLING_ERROR_18">sudo</span> /<span class="blsp-spelling-error"
id="SPELLING_ERROR_19">mnt</span>/Linux/Install.sh, it tells you you're
running an unsupported distribution. I thought I'd be clever and try the
force it to use the Debian 3 tools:  
<ol><li>Type: <span style="font-family:courier new;"><span
class="blsp-spelling-error" id="SPELLING_ERROR_20">sudo</span> /<span
class="blsp-spelling-error"
id="SPELLING_ERROR_21">mnt</span>/Linux/install.sh -d <span
class="blsp-spelling-error" id="SPELLING_ERROR_22">debian</span> -m
3</span></li><li>Reboot: <span style="font-family:courier new;"><span
class="blsp-spelling-error" id="SPELLING_ERROR_23">sudo</span> shutdown
-r now</span>  
</li></ol><blockquote></blockquote><span>That left me with an <span
class="blsp-spelling-error" id="SPELLING_ERROR_24">unbootable</span>
kernel. I booted from the original <span class="blsp-spelling-error"
id="SPELLING_ERROR_25">Ubuntu</span> kernel, then edited <span
style="font-family:courier new;">/boot/grub/menu.<span
class="blsp-spelling-error" id="SPELLING_ERROR_26">lst</span></span> to
change the default kernel to 2 so it would boot the good kernel.  
**  
**</span>

