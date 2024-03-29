---
layout: post
title: iPhone Tethering Notes for Ubuntu Vancouver LoCo
date: '2009-07-10T07:12:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- iPhone
modified_time: '2009-12-20T07:57:29.035-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1092062308245052793
blogger_orig_url: http://technopragmatica.blogspot.com/2009/07/iphone-tethering-notes-for-ubuntu.html
---

I gave a lightning talk at the Ubuntu Vancouver Local Committee July 9,
2009 on accessing the Internet from an Ubuntu computer through the
iPhone.  
<ul><li>Use the instructions from the Ubuntu forums [here][1]. [This
other page][2] gives the underlying commands used by the script from the
Ubuntu forum. You may find it helpful if the script doesn't work for
you.</li><li>During installation, when you're asked to make the iPhone
discoverable, go to Settings-&gt; General-&gt; Bluetooth and turn on
Bluetooth.</li><li>Part way through the instructions in the Ubuntu forum
you're asked to "pair" your iPhone with the computer. To "pair" your
iPhone with your computer:</li></ul><ol><li>Click on the blue icon with
white triangles that you'll find amount the other notification icons,
typically in the upper-right corner of your screen.</li><li>Select "Set
up new device..."</li><li>Click "Forward".</li><li>Wait for your iPhone
to appear in the list. If it doesn't, go back to Settings-&gt;
General-&gt; Bluetooth on the iPhone and make sure Bluetooth is on.
Also, make sure your iPhone is less than a 1/2 metre from your
computer.</li><li>Select your iPhone in the list and click
"Forward".</li><li>Ubuntu will show you a four-digit code and ask you to
enter it on the device. The iPhone will have a keypad showing. Enter the
code.</li><li>Ubuntu will ask if you want to allow the connection.
Select "Always allow" and click "OK".</li><li>You're now
paired.</li></ol><ul><li>Before trying to tether your computer to the
iPhone, go back to Settings-&gt; General-&gt; Bluetooth. Your computer's
name with "-0" appended should appear below the on/off button. If it
says "Not connected" beside your computer's name, click on the computer
name and wait for it to change to "Connected".</li><li>Using Network
Manager, turn off other network connections you may have running before
tethering.  
</li><li>Finally, before running the script, don't forget to turn on
Internet Tethering on the iPhone. Go to Settings-&gt; General-&gt;
Network-&gt; Internet Tethering and turn Internet Tethering
on.</li><li>Keep the iPhone with 1/2 metre of your computer. (You can
try more, but I suspect that the flaky connection I sometimes experience
may be associated with the distance between the phone and the
computer.)</li><li>After running the script, you still won't be able to
browse the Internet. (You don't have any usable DNS servers defined on
your computer.) Do the following in a terminal:</li></ul>sudo cat
&gt;&gt;/etc/resolv.conf &lt;&lt;-END nameserver 208.67.220.220
nameserver 208.67.222.222 END   
<ul><li>I put the above in my uit.sh script at the appropriate
place.</li> <li>Remember to turn off Internet Tethering and Bluetooth on
the iPhone when you're done.</li> <li>Disconnect tethering on your
computer by running: sudo ./uit.sh -d  
</li> <li>Don't forget to reconnect your computer to your usual networks
after you turn off tethering.  
</li> </ul>Troubleshooting  
<ul><li>My experience is that you have to do everything in exactly the
right order. If something goes wrong, do the following and then start
over:</li></ul><ol><li>On the iPhone, go to Settings-&gt; General-&gt;
Network-&gt; Internet Tethering and turn Internet Tethering
off.</li><li>On the iPhone, go to Settings-&gt; General-&gt;
Network-&gt; Bluetooth and turn Bluetooth off</li><li>On your computer,
run the disconnect script: sudo ./uit.sh -d</li><li>On your computer,
restart Bluetooth: sudo /etc/init.d/bluetooth
restart</li></ol><ul><li>The Bluetooth connection seems to be
unreliable. Sometimes I can browse a page or two and then it stops
working. Sometimes it just doesn't connect at all. After two or three
tries I usually get a reliable connection. Every time it fails, be sure
to do all the steps in the above list.</li></ul>



[1]: http://ubuntuforums.org/showthread.php?t=1195655
[2]: http://xn--9bi.net/2009/06/17/tethering-iphone-3-0-to-ubuntu-9-04/
