---
layout: post
title: Cheap Hosting Part II
date: '2009-03-12T07:44:00.000-07:00'
author: Larry Reid
tags:
- Drupal
- Collaboration
- PAC
modified_time: '2009-04-17T07:06:11.016-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6968958692361334831
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/hosting-websites-part-ii.html
---

In an [earlier post][1] I described how I was running out of memory in
PHP using a moderate set of Drupal contributed modules.  
  
It turns out I was able to increase the PHP memory on my HostPapa hosted
site. The method to use it to add the following line to Drupal's
"settings.php" file in <span style="font-style: italic;">each
site's</span> "files" directory:<pre>ini\_set('memory\_limit',
'48M');</pre>Or if the line already exists, make sure the amount is
'48M'.  
  
One of the problems I think I had earlier is not changing the right
settings.php file. I have multiple sites in multiple sub-domains,
because the main purpose of this host is to do proofs-of-concept for
clients. I probably thought changing the settings.php file didn't work
because I changed the wrong one.  
  
Suppose you installed Drupal under public\_html. You have to change
settings.php in public\_html/sites/default to change the memory limit on
your main domain (for example, "example.com"). For a sub-domain
"test.example.com", you have to change settings.php in
public\_html/sites/test.example.com. And so on for any other sub-domains
you have.



[1]: http://technopragmatica.blogspot.com/2009/03/cheap-hosting-and-php-memory.html
