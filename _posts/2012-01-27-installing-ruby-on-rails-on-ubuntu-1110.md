---
layout: post
title: Installing Ruby on Rails on Ubuntu 11.10
date: '2012-01-27T10:08:00.000-08:00'
author: Larry Reid
tags:
- Ruby on Rails
modified_time: '2012-02-21T22:25:07.537-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7593359670339239360
blogger_orig_url: http://technopragmatica.blogspot.com/2012/01/installing-ruby-on-rails-on-ubuntu-1110.html
---

\[I've made an important change to this post -- steps 3 and 4 below are
new. Apologies to anyone I've lead astray.\]  
  
I'm back to playing with Rails a bit. NetBeans for Ruby is [gone][1], so
I'm going to do things the macho Rails way and just develop with an
editor and a bunch of terminal windows. (One of my open source rules is
"do whatever everyone else is doing." Trying to use an IDE with Rails
was always a violation of that rule.)  
[  
{: .Apple-interchange-newline}rvm][2]{: target="_blank"} is a great
idea. I found it really helpful to read about [named gemsets][3]{:
target="_blank"} early on. I had to install rvm, then install rails and
a few other packages.  
<div></div><ol><li>Install the Ruby Version Manager (rvm) from [these
instructions][4]{: target="_blank"}</li><li>Put this line at the end of
your .bashrc: "\[\[ -s "$HOME/.rvm/scripts/rvm" \]\] &amp;&amp; .
"$HOME/.rvm/scripts/rvm" # Load RVM function"</li><li>Run "rvm
requirements" in a terminal window</li><li><i>Install all the packages
the output of "rvm requirements" tells you to install (apt-get
install...). </i>You must do this before you start installing any rubies
with rvm. If you don't, you may have all sorts of problems crop up
later, like weird messages from irb ("Readline was unable to be
required, if you need completion or history install readline then
reinstall the ruby.")</li><li>Do the following in a terminal
window:</li></ol>`rvm 1.9.3 `  
`rvm --default 1.9.3 `  
`gem install rails `  
`sudo apt-get install sqlite `  
`sudo apt-get install libsqlite3-dev `  
`sudo apt-get install nodejs `  
  
Now create an application to test:  
  
`rails new testapp `  
`cd testapp `  
`rails server `  
  
Browse to localhost:3000 and you should see the Rails default page.



[1]: http://wiki.netbeans.org/RubySupport
[2]: http://beginrescueend.com/
[3]: http://beginrescueend.com/gemsets/basics/
[4]: http://beginrescueend.com/rvm/install/
