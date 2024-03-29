---
layout: post
title: Tethered iPhone
date: '2009-06-26T18:26:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- iPhone
modified_time: '2009-07-13T10:29:54.021-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7010355583674359470
blogger_orig_url: http://technopragmatica.blogspot.com/2009/06/tethered-iphone.html
---

I'm posting this from my laptop sitting outside Marc's Karate dojo with
my iPhone in my pocket providing my Internet connection over Bluetooth.
I can't help but be geekily happy about this. I never bothered to set up
the tethering before OS 3.0, so it's new to me. This is old news to the
hardcore users.  
  
I guess a new thing is that Fido is cool with the fact that I've
tethered. Not that I care what they think, but phone companies are
vindictive enough to actually cut you off if they detected you were
tethering, so I feel a little better that it's legit. (Make sure you
read the [details][1] to be sure you're legit.)  
  
The best instructions I found are [here][2]. The instructions [here][3]
show the actual commands, which is useful to know when you're debugging.
It wasn't smooth for me because I didn't do the sequence in perfect
order, and it looks like once I messed it up I just couldn't get it to
connect. By going System-> Preferences-> Bluetooth and undoing the
Bluetooth pairing, I was able to go through the steps from the start and
get it working.  
  
The part I had out of order is that I didn't check to see that the
iPhone was actually connected to my laptop before attempting to tether
from the laptop. The Bluetooth screen on the iPhone has to say
"Connected", not just show the name of your laptop.  
  
While writing this I lost my connection and couldn't get it back until I
restarted Bluetooth on my laptop (sudo /etc/init.d/bluetooth restart). I
have no idea what that's about, but I've seen others on the Internet
complain that the connection isn't always reliable.



[1]: http://www.iphoneincanada.ca/iphone-news/new-tethering-policy-for-rogers-and-fido/
[2]: http://ubuntuforums.org/showthread.php?t=1195655
[3]: http://xn--9bi.net/2009/06/17/tethering-iphone-3-0-to-ubuntu-9-04/
