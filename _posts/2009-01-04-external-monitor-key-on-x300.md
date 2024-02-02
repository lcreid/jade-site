---
layout: post
title: External Monitor Key on the X300
date: '2009-01-04T07:58:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
- Lenovo x300
modified_time: '2009-01-04T08:09:43.965-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2871238607067543196
blogger_orig_url: http://technopragmatica.blogspot.com/2009/01/external-monitor-key-on-x300.html
---

| Out of the box, the external monitor key (Fn-F7) on my Lenovo X300 didn't work. I found a [great post][1] on the ThinkWiki that described how to do it. I followed the instructions up to and including the "set permissions and restart acpi" section.  
  
There was one small problem with the bash script that you put in <span style="font-family: courier new;">/usr/local/sbin/thinkpad-fn-f7</span>. Lines 39 and 40 didn't get the right values when one of the monitors was off, but still connected. I changed them to:  
<pre>INTERNAL\_STATE=$($SU xrandr | sed -n "s/$\{INTERNAL\_OUTPUT}\\Wconnected\\W(\[0-9\]+\[xX\]\[0-9\]++\[0-9\]++\[0-9\]+).\*/\\1/p")  
EXTERNAL\_STATE=$($SU xrandr | sed -n "s/$\{EXTERNAL\_OUTPUT}\\Wconnected\\W(\[0-9\]+\[xX\]\[0-9\]++\[0-9\]++\[0-9\]+).\*/\\1/p")</pre>and all was good.  
  
I posted my experience to the ThinkWiki discussion on the topic, so hopefully by the time you read this the fix will have been made there. |



[1]: http://www.thinkwiki.org/wiki/Sample_Fn-F7_script
