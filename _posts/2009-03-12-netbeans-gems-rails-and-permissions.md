---
layout: post
title: NetBeans, Gems, Rails, and Permissions
date: '2009-03-12T14:03:00.000-07:00'
author: Larry Reid
tags:
- Ubuntu
- Ruby on Rails
- NetBeans
modified_time: '2009-03-17T16:37:10.269-07:00'
thumbnail: http://3.bp.blogspot.com/_O0zu9v4qHys/Sbl-dCtnnKI/AAAAAAAACI4/mFYaEgtHAgk/s72-c/Screenshot-Ruby+Platform+Manager.png
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-725391679869583494
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/netbeans-gems-rails-and-permissions.html
---

I've gone from being a shell/make/rcs guy to quite liking IDEs, or at
least useful IDEs. I find NetBeans to be a pretty nice, light-weight (in
the good sense) IDE, but it has some issues on Ubuntu and other properly
secured OSs. Here's how I've got it to work. This applies to NetBeans
6.1 and 6.5, I believe.  
  
First, you have to set up your Ruby platforms so they keep their gems in
writable directories. Go to Tools-> Ruby Platforms. On NetBeans 6.5 (at
least), the jRuby gems are in a writable, per user path by default. If
you click on the "Autodetect Platforms" button and get the native Ruby
platform, change the "Gem Home:" and "Gem Path:" directories to
somewhere writable, like /home/reid/ruby/gems/1.8.  
  
While you're here, make sure the version of /usr/bin/gem is 1.3.1 or
higher. If it isn't, I think you have to upgrade from a shell. I did
that upgrade a while ago, so I don't remember how to do it, but you can
find out easily through Google. (Ubuntu users may want to look
[here][1].)  
  
It should all look like this:  
[![](http://3.bp.blogspot.com/_O0zu9v4qHys/Sbl-dCtnnKI/AAAAAAAACI4/mFYaEgtHAgk/s400/Screenshot-Ruby+Platform+Manager.png){:
style="cursor: pointer; width: 400px; height: 213px;"
#BLOGGER_PHOTO_ID_5312416272869727394 border="0"}][2]{: onblur="try
{parent.deselectBloggerImageGracefully();} catch(e) {}"}  
Now go re-install all the gems you need through Tools-> Ruby Gems.  
  
At this point, you still may not be able to install plugins. You'll get
the following message: "Missing the Rails 2.2.2 gem" (or whatever
version NetBeans installed for you). Rake from within NetBeans seems to
look at the system rails executable, and not the one installed through
the NetBeans' own gem installer. But the environment.rb generated for a
new application does use the version of Rails installed by NetBeans.
What I did (yuck, because there's some redundancy here) is manually
install the appropriate Rails version: <pre>sudo gem install
rails</pre>I'm sure there's a better way, but I can't think of it right
now and I really want to write some Rails code instead of fighting with
NetBeans.



[1]: http://intertwingly.net/blog/2008/11/23/RubyGems-1-3-1-on-Ubuntu-8-10
[2]: http://3.bp.blogspot.com/_O0zu9v4qHys/Sbl-dCtnnKI/AAAAAAAACI4/mFYaEgtHAgk/s1600-h/Screenshot-Ruby+Platform+Manager.png
