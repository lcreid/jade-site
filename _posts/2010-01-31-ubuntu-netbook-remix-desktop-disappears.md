---
layout: post
title: Ubuntu Netbook Remix Desktop Disappears
date: '2010-01-31T17:11:00.000-08:00'
author: Larry Reid
tags:
- Ubuntu
modified_time: '2010-01-31T17:11:07.982-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1507324803627909513
blogger_orig_url: http://technopragmatica.blogspot.com/2010/01/ubuntu-netbook-remix-desktop-disappears.html
---

I have a netbook running Ubuntu Netbook Remix (UNR) 9.04. I switched it
to the regular Ubuntu desktop just to try. Before I switched back, I
rebooted (the battery ran all the way down). Apparently, this is known
to be a bad thing. When you restart, all you get is a blank desktop --
no panels at the top and bottom to allow you to get at any commands.  
  
The fix is described in Launchpad [here][1], but I'm going to summarize
it because it's a little spread out in the comments to the bug.  
<ol><li>Right click on the desktop and select "Create
Folder..."</li><li>Double click on the folder you just
created</li><li>Navigate to "/usr/bin/desktop-switcher" and run
it</li><li>Switch back to the UNR desktop</li><li>Now navigate to your
home directory</li><li>Show hidden files (View-&gt; Show Hidden Files,
or Ctrl-h)</li><li>Delete the .gconf, .gconfd, and .config
folders</li><li>Log out and log back in</li></ol>This should fix the
problem. Now, with respect to the classical desktop, don't do that :-)



[1]: https://bugs.launchpad.net/desktop-switcher/+bug/349519
