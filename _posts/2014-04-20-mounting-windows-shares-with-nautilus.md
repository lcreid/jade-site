---
layout: post
title: Mounting Windows Shares with Nautilus
date: '2014-04-20T07:32:00.000-07:00'
author: Larry Reid
tags: 
modified_time: '2014-04-20T07:32:03.650-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-520462396450706247
blogger_orig_url: http://technopragmatica.blogspot.com/2014/04/mounting-windows-shares-with-nautilus.html
---

From time to time I need to access a Windows share on a domain (not is a
local work group) via Nautilus (the LinuxMint file browser I use). It
always takes me too long to figure out the trick...  
  
The trick: The domain has to be specified in upper case (or perhaps it's
simply case sensitive and it depends how the domain administrator has
specified the domain). So in Nautilus, I do File-&gt; Connect to
Server..., then fill in the appropriate values in the dialogue that
appears, with domain in upper case.  
  
To debug issues when connecting to Windows shares, I open a Terminal
window and type:  
  
smbclient -U *domain*\\*windows\_user\_name*
//*windows\_server\_name*/*share*  
  
and follow the prompts.  
  
If that works, I try:  
  
gvfs-mount
"smb://*domain*;*windows\_user\_name*@*windows\_server\_name*/*share*"  
  
and follow the prompts. (The quotes are required because the semi-colon
is a special character to the Terminal program.) I have seen cases where
the mount takes a minute or so to connect, so I have to be patient.  
  
If the above works, I unmount the drive with:  
  
gvfs-mount -u
"smb://*domain*;*windows\_user\_name*@*windows\_server\_name*/*share*"

