---
layout: post
title: Can't Connect to Console of VMs
date: '2008-03-25T20:11:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Virtualization
- IT Infrastructure
modified_time: '2008-03-25T20:27:37.612-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7316643970885910531
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/cant-connect-to-console-of-vms.html
---

I had everything built and running VMWare Server. Good. So I copied all
the VMs I'd built when I was running VMWare on my desktop over to the
new server. I started a few, and they were running fine. I could connect
to the [Zenoss][1] console on one of them, and could ping both. However,
all I got was a black screen when I tried to look at the console of the
VM using VMWare Console.  
  
The VMWare documentation recommended using the version of VMWare Console
program specific to the server you're running. I grumbled a bit and
re-installed (which was actually quite easy), then tried viewing the
console of my VMs again. I still got a black screen, but I also got an
error message saying that the <span style="font-family: courier
new;">.vmx</span> file had to have execute permission for the user
running the VMWare Console. I checked the <span style="font-family:
courier new;">.vmx</span> files and sure enough, because of the way I
copied them everything had 0644 permissions.  
  
So I cd'd to the directory where all the VM directories were and typed: 

  
<span style="font-family: courier new;">find . -name "\*.vmx" -exec
chmod u+x \{} \\;</span>  
  
That worked because the user connecting with VMWare Console is the same
one that owned all the files. You'll have to do something slightly
different if that's not the case.  
  
Now they work fine.



[1]: http://www.zenoss.com
