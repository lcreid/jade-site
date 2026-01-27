---
title: Captive Portals on Ubuntu
layout: kb
toc: true
---

## Captive Portals on Ubuntu

Captive portal is the name given to the technology behind most public WiFi: That page that pops up asking you to agree to some terms of use, comes from a captive portal.

Wikipedia has a [good article](https://en.wikipedia.org/wiki/Captive_portal#) about captive portals. According to Wikipedia, there are different ways to implement captive portals. This would explain one of the symptoms I've seen: the exact same laptop and operating system well connect fine at one place, but fail miserably at another.

I have been having problems with connecting in some hotels and airports with my Ubuntu 24.04 laptop. (I had the problems when I was running 22.04, too.) According to the Wikipedia article, one of the ways to implement captive portal requires that the client make an HTTP request, _not_ HTTPS, because HTTPS can't be redirected without warnings. On Ubuntu, NetworkManager makes this request. But as near as I can tell, Ubuntu's NetworkManager is configured to request an HTTPS URI.

I added the following to `/etc/NetworkManager/NetworkManager.conf` (note that is says `http:`):

```
[connectivity]
uri=http://connectivity-check.ubuntu.com/
response=NetworkManager is online
interval=300
```

Then restart:

```bash
sudo systemctl restart systemd-networkd
```

I seem to be connecting to captive portals now without problems, including some that caused grief before.
