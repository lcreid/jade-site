---
layout: post
title: Connecting to DFS Shares with Ubuntu
date: '2011-03-13T07:38:00.000-07:00'
author: Larry Reid
tags:
- VPN
- Ubuntu
modified_time: '2011-03-27T17:09:45.474-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5072699250207650903
blogger_orig_url: http://technopragmatica.blogspot.com/2011/03/connecting-to-dfs-shares-with-ubuntu.html
---

See an important update [here][1]. The information that follows is still
relevant to mount.cifs.  
  
With my current client, when I'm working at home, I have to connect to a
CIFS share that uses Microsoft's DFS through their Cisco AnyConnect VPN.
It seemed like the mount would work, but I couldn't see any of the files
or folders below the share. (This is with Ubuntu 10.04 Lucid Lynx.)  
  
Fortunately, some other consultants working on the same project had the
same problem, and they found a work-around. The work-around was to
connect to the underlying server and folder, rather than through the DFS
root.  
  
As my position with this client has evolved, I've needed to get to other
folders on their file server, and I've occasionally had problems because
I didn't know the underlying server and folder I needed to get to. So I
continued to work on the problem. I think I've found the solution.  
  
I already had the keyutils package installed. You'll need it:  
  
<span class="Apple-style-span" style="font-family: inherit;">sudo
apt-get install keyutils</span>  
  
Then I added the following two lines to /etc/request-key.conf:  
  
<span class="Apple-style-span" style="font-family: inherit;">create<span
class="Apple-tab-span" style="white-space: pre;">
</span>cifs.spnego<span class="Apple-tab-span" style="white-space:
pre;"> </span>*<span class="Apple-tab-span" style="white-space: pre;">
</span>*<span class="Apple-tab-span" style="white-space: pre;">
</span>/usr/sbin/cifs.upcall %k %d</span>  
<span class="Apple-style-span" style="font-family: inherit;">create    
 dns\_resolver<span class="Apple-tab-span" style="white-space: pre;">
</span>*<span class="Apple-tab-span" style="white-space: pre;">
</span>*<span class="Apple-tab-span" style="white-space: pre;">
</span>/usr/sbin/cifs.upcall %k</span>  
<div>  
</div><div>Now I can connect to the DFS root if I use a mount command in
a Terminal window.  
  
  
sudo mount -t cifs --verbose -o user=my\_domain/my\_user\_id
//my\_server/my\_share /mnt  
<div>  
</div>  
It still doesn't work if I try to connect to the share with
Nautilus. </div><div>  
</div><div>(A quick check of a VM of 11.04 alpha 2 that I had lying
around shows the above two lines are already in
/etc/request-key.conf.)</div><div>  
</div><div>I haven't been using the fix for a long time, yet, so I don't
know if it's the complete solution. I've noticed so far that sometimes
Nautilus times out and doesn't get the file and folder list from the
share. When I refresh the view in Nautilus it works fine.  
  
One of the key hints to find the solution was this text in my dmesg log:

<span class="Apple-style-span" style="font-family: 'DejaVu Sans',
'Liberation Sans', sans-serif; font-size: x-small;" />  
<pre class=\"bz\_comment\_text\" style=\"font-family: monospace;
font-size: medium; white-space: pre-wrap; width: 50em;\">CIFS VFS:
cifs\_compose\_mount\_options: Failed to resolve server part
of...</pre></div><div>  
</div><div>Note that it turned out to have nothing to do with the VPN.
Also, it leaves open the mystery as to why the other consultants, who
were using Windows Vista, I think, also had to use the same
work-around.</div><div>  
</div><div>  
</div>



[1]: http://technopragmatica.blogspot.com/2011/03/debugging-windows-shares-and-samba.html
