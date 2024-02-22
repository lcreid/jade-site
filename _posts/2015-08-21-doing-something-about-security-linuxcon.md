---
layout: post
title: 'Doing Something About Security -- Linuxcon 2015 #3'
date: '2015-08-21T21:44:00.000-07:00'
author: Larry Reid
tags:
- Linuxcon
- Linuxcon2015
modified_time: '2015-08-21T21:44:12.657-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-8789791872181066703
blogger_orig_url: http://technopragmatica.blogspot.com/2015/08/doing-something-about-security-linuxcon.html
---

The [Let's Encrypt][1]{: target="_blank"} people are wonderful. They're
doing something about the state of security on the Internet. They're
providing an easy and free way to get the certificates you need to
publish a secure web-site (one using HTTPS, instead of plain HTTP), like
your bank does.

If you've run a secure web site, you'll know that it's expensive,
inflexible, takes time to set up, and requires you to remember to renew
the certificate. Let's Encrypt solves most of those problems for you, at
least in a common use case.

{: .Apple-interchange-newline}If you run a server with a dedicated IP,
have privileges to install software on that server (i.e. you can run
`apt-get` or `yum`), and you use Apache or Nginx as your HTTP server,
then it's [brain-dead simple to switch to HTTPS][2]{: target="_blank"}.

Let's Encrypt is planning on going live sometime in the last
quarter of 2015. Right now they're in a restricted beta, and users will
see browser warnings about your site if you use their certificates. When
they go live, they'll be backed by [IdenTrust][3]{: target="_blank"}, so
users will have the same warning-free experience that any other secure
site would have.

But even if it's not ready to use for the general public, you can help
them test. (At the moment, you can't use apt or yum to install the Let's
Encrypt client. Read these [installation instructions][4]{:
target="_blank"} instead.)

There are lots of use cases that aren't helped by Let's Encrypt yet.
Probably the most glaring are for the legions of us that use $3/month
hosting services that don't give us a fixed IP and a way to install the
Let's Encrypt client. Still, it's a big step forward for a secure web.



[1]: https://letsencrypt.org/
[2]: https://letsencrypt.org/howitworks/
[3]: https://www.identrustssl.com/
[4]: https://letsencrypt.readthedocs.org/en/latest/using.html
