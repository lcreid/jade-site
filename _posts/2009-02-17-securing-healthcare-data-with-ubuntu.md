---
layout: post
title: Securing Healthcare Data with Ubuntu Desktop
date: '2009-02-17T09:57:00.001-08:00'
author: Larry Reid
tags:
- Ubuntu
- Healthcare IT
modified_time: '2009-02-17T10:39:29.770-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4227525874217176251
blogger_orig_url: http://technopragmatica.blogspot.com/2009/02/securing-healthcare-data-with-ubuntu.html
---

People's personal health care data has to be kept confidential. The
reality of working in health care IT is that you have to put work on a
USB stick or use a laptop. At least Ubuntu makes it easier to do the
right thing.  
  
I knew I had to do something about the data on my laptop (Ubuntu 8.10),
so I sat down one day to figure out what to do. I knew the tools were
there, but where to start? Almost absent-mindedly I right clicked on the
folder I needed to encrypt, and saw that there's an "Encrypt..." command
right there on the menu. (Note that you have to be pointing at the file
or folder in the right pane of the Nautilus file manager.)  
  
"That was easy," I said to myself. I selected the "Encrypt..." command.
Since this was the first time, it took me through a number of steps to
generate some keys. I just followed the dialogues. On my Lenovo x300 it
took several minutes to generate the keys after I got through the
dialogues. I was starting to worry if something was wrong, but patience
prevailed.  
  
Once the key is generated, I could go back to encrypting my folder. I
selected the option to "Encrypt all files together in a package." After
it was done, which wasn't long at all, I was left with the original
folder, the folder.zip file, and a folder.zip.pgp file. The ".pgp" file
is the encrypted one, so I deleted the original folder and the
folder.zip file.  
  
Then I had to make sure that the files can't be reconstructed by someone
with the right tools and access to my laptop. I opened a terminal window
and did this:  
<pre>dd if=/dev/zero of=junk  
rm junk</pre>The first command takes quite a while. It writes zeros to
all the free space on my disk. The more free space, the longer it takes.
When it fills the disk, it stops. The second command deletes the file,
so I have all my free space back. (If you don't know why I did this,
read the last paragraph of this article.)  
  
I've heard that there are ways to get data back from disks even if
they've been completely re-written. Leave a comment if you know more
about the practicality of restoring zeroed hard drives. The above
approach certainly foils a relatively determined attempt to get the data
back, and should put you in good stead with your privacy people.  
  
Note that this process still isn't one I'd want to do every time I had
to access some personal health care data on my laptop. It's a manual
process, meaning I might forget to do it or won't have time to do it
that one time just before I leave my laptop in the rental car at the
airport. It also takes time, especially if you have a lot of free space
on your disk.  
  
If you don't know why you have to write zeros on all your free space,
here's why: When you delete a file on your computer, you don't actually
erase the data. You just mark it as available for re-use. Someone with
the right knowledge (and there are many who have this knowledge) can
reconstruct old data on your disk. If you write zeros over the free
space, you ensure that there's no data for them to reconstruct.

