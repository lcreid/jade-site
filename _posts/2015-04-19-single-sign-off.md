---
layout: post
title: Single Sign-Off
date: '2015-04-19T10:28:00.000-07:00'
author: Larry Reid
tags: 
modified_time: '2015-04-19T10:28:26.456-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6295885858572302810
blogger_orig_url: http://technopragmatica.blogspot.com/2015/04/single-sign-off.html
---

One of the things I find amusing about the IT business is how often we
create unintended consequences for ourselves.  
  
Last week at work we ran into an interesting dilemma: We have a nice
set-up to enable some level of single sign-on for our external users
(business partners), across a suite of applications they use. We're
preparing to deploy some browser-based COTS software into that suite of
applications. Like most applications, the new one has a "log out"
button.  
  
When the user logs out, we'd like to take them back to a page that says,
"You have logged out. To log on again click here." But we can't, because
once they click on the log-out link, our "single sign-on" becomes
"single sign-off". Before they can see any page on our partner network,
we have to send them to our corporate log-in page.  
  
We have options, so it's not like this is a huge problem. But no one
thought of it before, so we're going through a bit of churn while people
get their head around the problem and decide how they want to deal with
it.  
  
So don't forget, "single sign-on" also means "single sign-off".

