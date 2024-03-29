---
layout: post
title: DNS with DD-WRT and dnsmasq
date: '2015-04-26T09:00:00.001-07:00'
author: Larry Reid
tags:
modified_time: '2015-04-28T08:10:33.730-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7561452807047689834
blogger_orig_url: http://technopragmatica.blogspot.com/2015/04/dns-with-dd-wrt-and-dnsmasq.html
---

I recently switched ISPs. I had been a broadband customer for 15 years
with the same ISP. I had a fairly complicated home network with a few
routers, one of which provided DHCP and DNS. Between my network and the
ISP’s, I had a simple ADSL modem with no additional functionality (i.e.
no built-in wireless or router).

My new cable modem (an Arris/Motorola SBG6782) came with wireless, four
wired LAN ports, and a router. Basic connectivity was up very quickly,
and we were able to start connecting wirelessly to the new network.

Unfortunately, the new modem/router is also “idiot-proofed” by the
manufacturer and/or the ISP. Among other features, I’m forced to use the
“192.168.0/24” subnet for my LAN. Way back, for reasons that I have
mostly forgotten, I set up my LAN on “10.3.3.0/24”. This meant that all
my network infrastructure, including file servers, storage boxes,
printers, backup destinations, etc. were all broken by the new router.

After a couple of unsuccessful attempts to make the router act only as a
modem, I decided that reconfiguring my network was probably the quickest
solution. (The ISP’s support forums suggested it was possible, but it
didn’t work for me, and their customer support denied all knowledge of
how to do it.)

In my old network, one DD-WRT-based router was connected to the ADSL
modem (Internet) via the router’s WAN port. That router provided DHCP
and DNS for my network. The DNS provided addresses for devices in my
network with static IPs and those that got addresses from DHCP.

For the new network, I disconnected the WAN port and hooked the LAN side
of the router into an 8-port switch that was also connected to the cable
modem. I changed all the relevant IP addresses in the router to
“192.168.0.x” addresses. Tedious, but it mostly worked.

The part that didn’t work was DNS. If I had DHCP on my router hand out
my router’s IP as the DNS server, I could look up hosts on my LAN, but
not on the Internet. If I hard coded the ISP’s DNS servers into my
router, I could look up hosts on the Internet, but not on my LAN.

Since my router was no longer using DHCP to get its Internet address
from the ISP, the magic done by DD-WRT and/or `dnsmasq` to configure the
DNS service wasn’t working any more.

After a bit of Googling, and reading [dnsmasq documentation][1], I
decided that what was missing was to put the ISP’s DNS servers into the
router’s `/tmp/resolv.dnsmasq` file. So in the Administration-&gt;
Commands page of the router’s web interface, I added these lines to the
start-up script:

    echo 'nameserver 64.59.144.93' >> /tmp/resolv.dnsmasqecho 'nameserver 64.59.150.139' >> /tmp/resolv.dnsmasqkillall -HUP dnsmasq

After rebooting the router, and disconnecting and reconnecting my
computer to force it to get the new settings from the router, DNS works.

I’m not sure if this is the “right” way to do it, but it works.



[1]: http://www.thekelleys.org.uk/dnsmasq/docs/setup.html
