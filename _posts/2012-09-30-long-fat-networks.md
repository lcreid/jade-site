---
layout: post
title: Long Fat Networks
date: '2012-09-30T18:04:00.000-07:00'
author: Larry Reid
tags:
- Relocation
- IT Infrastructure
- Samba
- CIFS
modified_time: '2012-11-01T12:10:23.576-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8050903804908649918
blogger_orig_url: http://technopragmatica.blogspot.com/2012/09/long-fat-networks.html
---

Long fat networks are high bandwidth, high latency networks. "High
latency" is relative, meaning high latency compared to a LAN.  
  
I ran into the LFN phenomena on my last data centre relocation. We moved
the data centre from head office to 400 kms from head office, for a
round trip latency of 6 ms. We had a 1 Gbps link. We struggled to get a
few hundred Mbps out of large file transfers, and one application had to
be kept back at head office because it transferred large files back and
forth between the client machines at head office and its servers in the
data centre.  
  
I learned that one can calculate the maximum throughput you can expect
to get over such a network. The calculation is called the "[bandwidth
delay product][1]{: target="_blank"}", and it's calculated as the
bandwidth times the latency. One way to interpret the BDP is the maximum
window size for sending data, beyond which you'll see no performance
improvement.  
  
For our 1 Gbps network with 6 ms latency, the BDP was 750 KB. Most TCP
stacks in the Linux world implement TCP window scaling ([RFC1323][2]{:
target="_blank"}) and would quickly auto tune to send and receive 750 KB
at a time (if there was enough memory available on both sides for such a
send and receive buffer).  
  
SMB 1.0 protocols used by most anything you would be doing on
pre-Windows Vista are limited to 64 KB blocks. This is way sub-optimal
for a LFN. Vista and later Windows use SMB 2.0, which can use larger
block sizes when talking to each other. [Samba 3.6][3]{:
target="_blank"} is the first version of Samba to support SMB 2.0.  
  
We were a typical corporate network in late 2011 (read, one with lots of
Windows machines), and they were likely to suffer the effects of a LFN. 

  
Note that there's not much you can do about it if both your source and
destination machines can't do large window sizes. The key factor is the
latency, and the latency depends on the speed of light. You can't speed
that up.   
  
We had all sorts of fancy WAN acceleration technology, and [we couldn't
get it to help][4]{: target="_blank"}. In fact, it made things worse in
some situations. We never could explain why it was actually worse.
Compression might help in some cases, if it gets you more bytes passing
through the window size you have, but it depends on how compressible
your data is.  
  
(Sidebar: If you're calculating latency because you can't yet measure
it, remember that the speed of light in fibre is only about 60 percent
of the speed of light in a vacuum, 3 X 10^8 m/s.)  
  
There are a couple of good posts that give more detail [here][5]{:
target="_blank"} and [here][6]{: target="_blank"}.



[1]: http://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;ved=0CCwQFjAA&amp;url=http%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBandwidth-delay_product&amp;ei=uHNoUKnyNYiEiwKSzYHAAw&amp;usg=AFQjCNG1t27O8FNYcLWEaqD6QTLJmsFYew
[2]: http://www.ietf.org/rfc/rfc1323.txt
[3]: http://www.samba.org/samba/news/releases/3.6.0.html
[4]: http://technopragmatica.blogspot.ca/2011/11/running-over-wan-after-relocating-data.html
[5]: http://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=3&amp;cad=rja&amp;ved=0CD0QFjAC&amp;url=http%3A%2F%2Fitperformancemanagement.blogspot.com%2F2010%2F04%2Ftcp-throughput-over-long-fat-networks.html&amp;ei=uHNoUKnyNYiEiwKSzYHAAw&amp;usg=AFQjCNH9a-lD147Xovffk9cO59AccpRldg
[6]: http://scrutin.wordpress.com/2007/04/30/elephants-on-the-network-lfns-long-fat-networks-bandwidth-versus-latency/
