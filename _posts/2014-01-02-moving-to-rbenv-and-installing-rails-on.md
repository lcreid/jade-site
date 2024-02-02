---
layout: post
title: Moving to rbenv and Installing Rails on LInux Mint 13
date: '2014-01-02T06:38:00.001-08:00'
author: Larry Reid
tags:
- rbenv
- Ruby on Rails
modified_time: '2014-01-02T06:38:58.714-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-2438295518403207404
blogger_orig_url: http://technopragmatica.blogspot.com/2014/01/moving-to-rbenv-and-installing-rails-on.html
---

I'm back to doing a bit of Rails. As always, the world has moved on.
Rails is at 4.0.2, and Ruby 2.0 is out. The Rails folks are recommending
[rbenv][1]{: target="_blank"} to manage different Ruby versions and
their gems. I knew I still had some learning to do to be using
[rvm][2]{: target="_blank"} properly, so I decided to invest the
learning time in learning rbenv, since that's what the mainstream was
using.  
  
First, I had to remove the lines at the end of my ~/.bashrc, ~/.profile,
and ~/.bash\_profile, and restart all my terminal windows.   
  
I followed the rbenv installation instructions here:
[https://github.com/sstephenson/rbenv#installation][3], including the
optional [ruby-build installation][4]{: target="_blank"}.  
  
Then, I did:  
  
rbenv install -l  
  
that shows 2.0.0-p353 as the newest production version of MRI. So I did:

  
rbenv install 2.0.0-p353  
rbenv rehash # Either this or the next was necessary to avoid trying to
install Rails in the system gem directories.  
rbenv global 2.0.0-p353   
gem install rails  
rbenv rehash # Don't forget this again  
  
Now I was ready to test a new application:   
  
rails new example  
cd example  
rails server  
  
Then I pointed a browser to: http://localhost:3000, and voilà.  
  
I'm not sure I want to leave the rbenv global in place...



[1]: https://github.com/sstephenson/rbenv
[2]: http://rvm.io/
[3]: https://github.com/sstephenson/rbenv#installation
[4]: https://github.com/sstephenson/ruby-build#installing-as-an-rbenv-plugin-recommended
