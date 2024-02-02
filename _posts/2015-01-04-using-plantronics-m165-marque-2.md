---
layout: post
title: Using Plantronics M165 Marque 2 Bluetooth Headset with Linux
date: '2015-01-04T17:50:00.001-08:00'
author: Larry Reid
tags: 
modified_time: '2015-10-21T16:02:20.238-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4241727560009556634
blogger_orig_url: http://technopragmatica.blogspot.com/2015/01/using-plantronics-m165-marque-2.html
---

The [Plantronics M165 Marque 2][1] Bluetooth headset paired very nicely
with my Android phone. To pair it to my computer running Linux Mint 17
I:  
<ol><li>Clicked on the Bluetooth icon</li><li>Turned on
Bluetooth</li><li>Clicked “Set up a new device…”</li><li>Pressed and
held the Call button on the headset for five or six seconds, until the
computer found the headset (the Plantronics documentation is
[here][2])</li></ol>The sound test in the Sound Settings dialogue didn’t
sound right, but I could play music through the headset and it sounded
recognizable.  
Using it with Skype gave super-sucky sound quality. Lowering the PCM
level in `alsamixer` to about 70 made the sound quality a lot better,
but still not great (lowering the PCM level was suggested [here][3]).  
`alsamixer` is a command-line application. Open a Terminal and type:
`alsamixer`, then use the left and right arrow keys to find “PCM”, and
use the up and down arrow keys to set the level.  
Still trying to improve the sound quality, I noticed that the built-in
microphone is on when the headset is on. On a Skype test call, manually
turning off the microphone didn’t seem to make a lot of difference to
the sound quality.  
Using Audacity to record sound, the quality of the built-in microphone
was even worse than the headset.  
\[Edit\] Using the headset, I made a Skype call to my son, and he said
the quality of my voice was okay. I could also hear him okay.  
In case you need to know, the Bluetooth config files are in
`/etc/bluetooth`.



[1]: http://www.plantronics.com/ca/search/index.jsp?term=m165+marque+2
[2]: http://www.plantronics.com/ca/support/kb/detail.jsp?vfurl=/articles/en_US/How_To/RN17509&amp;p=&amp;c=Mobile_Cordless&amp;k=pair%20with%20computer&amp;t=How_To__kav&amp;lang=en_US&amp;popup=false
[3]: http://www.tomshardware.com/answers/id-2192627/poor-linux-sound-quality-driver-issue.html
