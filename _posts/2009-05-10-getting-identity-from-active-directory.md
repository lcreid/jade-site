---
layout: post
title: Getting Identity From Active Directory
date: '2009-05-10T07:51:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- Identity
- Search
modified_time: '2009-05-11T09:10:58.133-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2957028836768750941
blogger_orig_url: http://technopragmatica.blogspot.com/2009/05/getting-identity-from-active-directory.html
---

I needed a test environment where I could test mounting and accessing
Windows shares on a Linux machine, using identities and permissions
obtained from Active Directory (AD). After the initial setup, I wanted
to run a processes periodically in the background, without user
intervention. Therefore, having the user enter the password each time
wasn't an option. Also, the background process would be run periodically
forever in the future. I didn't want to store passwords because the
processes would fail after the user changed their password (and it's not
a good idea to store passwords anyway).  
  
The [Kerberos][1] authentication scheme in Windows and Linux uses
tickets, which can be used to prove that a process is acting on behalf
of a user. A user gets a ticket by requesting one and providing their
password. Until that ticket expires, processes that support Kerberos can
be run with the permissions of that user.  
  
So let's say we want to access a Windows share as user "testa", which is
a <span style="font-style: italic;">Windows</span> user known to the AD
server. The Linux machine asks for a ticket for testa, using testa's
password. The AD server validates the password and gives the Linux
machine a ticket. The Linux machine can then mount the Windows share
using Kerberos authentication. Accesses to the files and directories on
the share will then be allowed or denied based on testa's permissions.  
  
I built an AD server on Windows 2003 Server SP2. The client machine was
Ubuntu Desktop Edition 9.04.  
  
Here's how I went about it:  
<ol><li>Build an Active Directory server accepting the defaults. This
included allowing it to set up its own DNS server. I already have DNS
servers in my network, but I'm not a DNS expert. I've had bad luck
changing my DNS setup in the past, so for this test I just let AD do its
thing.</li><li>Install required packages on the Linux machine:  
</li>  
sudo apt-get install krb5-user keyutils  
  
<li>Replace the installed /etc/krb5.conf with the following. You have to
replace "my.domain.tld" with your own domain, of course. Be careful to
copy uppercase and lowercase:</li>  
\[libdefaults\]  
default\_realm = MY.DOMAIN.TLD  
default\_checksum = rsa-md5  
  
  
\[realms\]  
MY.DOMAIN.TLD = \{  
kdc = ADServer.my.domain.tld  
}  
  
\[domain\_realm\]  
.my.domain.tld = MY.DOMAIN.TLD  
my.domain.tld = MY.DOMAIN.TLD  
  
<li>Add the following line to /etc/request-key.conf. The order of the
lines is important. I put it last and nothing changed. I put it first
and everything worked:</li>  
create cifs.spnego \* \* /usr/sbin/cifs.upcall %k %d  
  
<li>Get a key with kinit. Run kinit with sudo. The ticket you get is for
the AD user testa whether you run as sudo or not, but the place that
kinit stores the ticket depends on the Linux user who runs kinit. Since
the mount command runs as root, you have to get a ticket for root or
mount won't find the ticket  
</li>  
sudo kinit -f testa  
  
<li>Mount the share, replacing "FileServer", "Share", and "/tmp/mnt"
with appropriate values for your systems:</li>  
sudo mount -t cifs -o sec=krb5i //FileServer/Share /tmp/mnt  
</ol>For a while I was getting "mount error(2): No such file or
directory" when I tried to mount. It was because I hadn't installed the
keyutils package.  
  
I've tested this up to and including the mount. I haven't finished
testing the background process I originally wanted to build. I may
modify this post based on my testing experience, so check back later.



[1]: http://en.wikipedia.org/wiki/Kerberos_%28protocol%29
