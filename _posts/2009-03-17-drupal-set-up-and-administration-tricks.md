---
layout: post
title: Drupal Set-Up and Administration Tricks
date: '2009-03-17T16:34:00.000-07:00'
author: Larry Reid
tags:
- Drupal
- PAC
modified_time: '2009-04-17T07:05:01.861-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4019172288553096284
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/drupal-set-up-and-administration-tricks.html
---

I can't claim to be the world's [Drupal][1] expert yet, but I'm learning
some interesting tricks that are worth documenting and sharing.  
  
First, my Drupal installations typically include a lot of contributed
modules. They're distributed as .tar.gz files, which you upload to your
server and unpack in the appropriate place. This can get tedious and
error prone (e.g. I forget to unpack one).  
  
I built a template directory with a complete Drupal install on a Linux
box (you could do something similar with Windows if you had [cygwin][2]
or a similar set of Linux-like tools). I unpacked the Drupal version,
then went into the modules directory and unpacked all the modules I
typically use. That was easy to do with a script like this:<pre>for f in
<span style="font-style: italic;">module\_directory</span>/\*.gz; do tar
-xzf $f; done</pre>Your mileage may vary with that script, depending on
where you put the tar'd modules.  
  
This allows a couple of nice things:  
<ul><li>One module I use, [fckeditor][3], requires that you unpack the
basic (non-Drupal) installation for [FCKeditor][4] in a subdirectory of
the Drupal fckeditor module. With a little playing around, you can
easily do this in the template directory once, and then you have the
deployment set up correctly</li><li>I need to set a higher PHP memory
limit in Drupal's "settings.php" file. I can do it once in the template
directory and deploy many sites reliably (read why [here][5] and
[here][6])</li><li>You need to temporarily change the permission of the
"settings.php" file for installation, and create the
"sites/default/files" folder before navigating to the Drupal site for
the first time. I create them both and make them writable in the
template directories  
</li></ul>Then, tar and gzip the resulting directory tree. There's one
<span style="font-style: italic;">big</span> trick to this step. You
need to make sure you get the .htaccess file, so I include it
explicitly:<pre>tar -czf ../drupal-6.10-template.tar.gz \*
.htaccess</pre>There's a reason I don't just tar the template directory.
That would give me a tar file that would create a directory and expand
into it. On my hosting service, it's more convenient for me to expand
into the existing "public\_html" directory.  
  
The other "trick" isn't so much a trick yet, as it is thoughts on
running several Drupal sites from one installation. It seems to be a
Drupal pattern to create "multisite" configurations where you have
sub-domains running from the same Drupal source code (PHP files), but
with different databases, and different configurations and themes.  
  
This sounds good, and you would only have to update the files once for
all your sites. However, I think it also causes some problems:  
<ul><li>The technique for Drupal multisites that I found gives you a
circular symbolic link in the sites directory hierarchy. I believe this
causes problems when I try to copy the site prior to upgrading it (I
copy to have a backup)</li><li>The recommended Drupal upgrade procedure
requires that you take the site offline, disable all modules, and then
re-enable all modules after you upgrade. That means all your sites are
offline for the entire upgrade, rather than being able to do each site
quickly</li></ul>With the template approach, the pain of uploading the
files is gone. The rest of the work you have to do for each site anyway,
so it becomes almost the same amount of work to just run each site as a
completely independent Drupal installation.  
  
I'm going to try my template based upgrade and will post about the
experience then.



[1]: http://www.drupal.org/
[2]: http://www.cygwin.com/
[3]: http://drupal.org/project/fckeditor
[4]: http://www.fckeditor.net/
[5]: http://technopragmatica.blogspot.com/2009/03/hosting-websites-part-ii.html
[6]: http://technopragmatica.blogspot.com/2009/03/cheap-hosting-and-php-memory.html
