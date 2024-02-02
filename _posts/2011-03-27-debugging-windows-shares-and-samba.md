---
layout: post
title: Debugging Windows Shares and Samba
date: '2011-03-27T17:08:00.000-07:00'
author: Larry Reid
tags:
- Samba
- CIFS
- EMC
modified_time: '2011-03-27T17:08:07.190-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5002105802718959299
blogger_orig_url: http://technopragmatica.blogspot.com/2011/03/debugging-windows-shares-and-samba.html
---

I wrote [here][1] about a problem I had connecting to a Windows share
that was using DFS from my Ubuntu 10.04 laptop. Turns out I was wrong
about the issue being related to authentication.  
  
The issue was that my server was sending back a string without the
Windows file separator at the end (backslash "\"). I simply patched the
code at the relevant place to check if the file separator was missing
and put one in if needed. Not the most elegant patch, but probably less
likely to impact any other code.  
  
I'm being careful not to call this a bug in Samba. The file server was
an EMC NAS implementation. Fairly common, but not a standard Windows
server sharing files. Perhaps the EMC is out of spec on this point, or
perhaps the spec is ambiguous on trailing file separators. Given the
number of devices out there, I think it's reasonable to make the Samba
client code handle the case, regardless of what the spec says.  
  
I fed the patch to Ubuntu, because that's where I originally logged the
[issue][2]. [Building][3] Samba was remarkably hassle free, as was
[getting][4] the source from their git repository, thanks to good
documentation for both. My thanks to the Samba team for a great product.



[1]: http://technopragmatica.blogspot.com/2011/03/connecting-to-dfs-shares-with-ubuntu.html
[2]: https://bugs.launchpad.net/ubuntu/+source/samba/+bug/738968
[3]: http://samba.org/samba/docs/man/Samba-HOWTO-Collection/compiling.html
[4]: https://wiki.samba.org/index.php/Using_Git_for_Samba_Development
