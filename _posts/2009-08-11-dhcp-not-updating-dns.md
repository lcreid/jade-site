---
layout: post
title: DHCP Not Updating DNS
date: '2009-08-11T15:07:00.000-07:00'
author: Larry Reid
tags:
- named
- dns
- bind
- Ubuntu
- dhcp
modified_time: '2009-08-24T22:07:40.495-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3642334935414783070
blogger_orig_url: http://technopragmatica.blogspot.com/2009/08/dhcp-not-updating-dns.html
---

So I had a weird problem -- suddenly my DHCP server stopped updating my
DNS server when my main laptop that I use all the time renewed its DHCP
lease. It seemed to be working fine for all other machines on my
network.  
  
After much fooling around and some reading, I discovered in the middle
of some document a statement that the DHCP server keeps track of whether
it thinks it has updated the DNS server, to avoid one round trip when
renewing a lease. This means that if the DHCP server thinks it has
updated DNS, it won't try again and if the DNS server doesn't have that
address, it'll never get it.  
  
Well, the DNS server will never get it until you do the following on the
DHCP client machine to force a release of the lease:<pre>sudo dhclient
-r</pre>Once you do that and then renew the lease again (e.g. disconnect
and connect the network) everything is fine.

