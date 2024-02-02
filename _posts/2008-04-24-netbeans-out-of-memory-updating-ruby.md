---
layout: post
title: NetBeans Out of Memory Updating Ruby Gems
date: '2008-04-24T06:08:00.000-07:00'
author: Larry Reid
tags:
- Ruby on Rails
- NetBeans
modified_time: '2008-04-24T20:56:09.455-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7873085621274096783
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/netbeans-out-of-memory-updating-ruby.html
---

I got a message "Exception in thread "main" java.lang.OutOfMemoryError:
Java heap space" while updating Ruby Gems in NetBeans 6.0.1 on Windows
XP. It took a little longer than usual for me to find reports of this
problem using Google, but when I did I found that it is a known problem.

  
Someone suggested changing the command line arguments to NetBeans to
increase the size of the memory for the JVM, but that didn't work for
me. Instead, I figured out how to load gems from the command line, and
once I did that one time, I was able to use the gem manager in NetBeans.

  
So, in more detail: Originally I had installed NetBeans from a
privileged account using all the default options. To get new gems, in a
non-privileged account, I had to create two environment variables with
the following values:  
<span style="font-family: courier new;" /><blockquote><span
style="font-family: courier new;">set JAVA\_HOME=C:\\Program
Files\\Java\\jdk1.6.0\_05</span>  
<span style="font-family: courier new;">set JRUBY\_BASE=C:\\Program
Files\\NetBeans 6.0.1\\ruby1\\jruby-1.0.2</span></blockquote><span
style="font-family: courier new;" />Your values may differ, particularly
the version numbers. I wrote it here as you'd do it in the command
prompt window, but I actually did it using the System control panel.  
  
I opened a comment prompt window and did:  
<span style="font-family: courier new;" /><blockquote><span
style="font-family: courier new;">%JRUBY\_BASE%\\bin\\gem install
login\_generator</span>  
</blockquote>After a couple of minutes, everything seemed to end
normally. I did Tools->Ruby Gems from a running NetBeans instance and
didn't get the desired results, so I restarted NetBeans and then
Tools->Ruby Gems got me a list of gems, including login\_generator as an
installed gem.

