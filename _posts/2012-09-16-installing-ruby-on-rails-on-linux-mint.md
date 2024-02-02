---
layout: post
title: Installing Ruby on Rails on Linux Mint 13
date: '2012-09-16T08:10:00.000-07:00'
author: Larry Reid
tags:
- Ruby on Rails
modified_time: '2012-10-01T22:33:24.981-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-399872439606913173
blogger_orig_url: http://technopragmatica.blogspot.com/2012/09/installing-ruby-on-rails-on-linux-mint.html
---

A few months after my [last post][1]{: target="_blank"} about installing
Ruby on Rails, and much has changed. There was an issue with zlib so I
had to flail around a bit. The following instructions are what I think I
should have done:   
<ol><li>Run "sudo apt-get install zlib1g zlib1g-dev" in a terminal
window </li><li>Install the Ruby Version Manager (rvm) from [these
instructions][2]{: target="_blank"}</li><li>Run "rvm requirements" in a
terminal window</li><li><i>Install all the packages the output of "rvm
requirements" tells you to install (apt-get install...). </i>You must do
this before you start installing any rubies with rvm. If you don't, you
may have all sorts of problems crop up later, like weird messages from
irb ("Readline was unable to be required, if you need completion or
history install readline then reinstall the ruby.")</li><li>Do the
following in a terminal window:</li></ol>`rvm install 1.9.3-p194 `  
`rvm --default 1.9.3``-p194`  
`gem install rails `  
`sudo apt-get install sqlite `  
`sudo apt-get install libsqlite3-dev libmysqlclient-dev`  
`sudo apt-get install nodejs `  
  
Now create an application to test:  
  
`rails new testapp `  
`cd testapp `  
`rails server `  
  
Browse to localhost:3000 and you should see the Rails default page.



[1]: http://technopragmatica.blogspot.ca/2012/01/installing-ruby-on-rails-on-ubuntu-1110.html
[2]: http://beginrescueend.com/rvm/install/
