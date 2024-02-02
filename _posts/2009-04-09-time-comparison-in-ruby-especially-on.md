---
layout: post
title: Time Comparison in Ruby, especially on Rails
date: '2009-04-09T16:38:00.000-07:00'
author: Larry Reid
tags:
- Ruby on Rails
modified_time: '2009-04-09T17:05:40.991-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-632070095579761671
blogger_orig_url: http://technopragmatica.blogspot.com/2009/04/time-comparison-in-ruby-especially-on.html
---

I had a bizarre failure in some test cases. The test case looked like
this:<pre>marker = Time.now  
t.create(args)  
assert t.created\_at.between?(marker, Time.now)</pre>In other words,
take the time, create an object, and make sure it was created between
the first time and now. Obviously true, but my test was failing.  
  
The reason: Rails keeps the create time to the second, but Ruby keeps
time to fractions of a second (depending on the resolution of your
hardware clock). Both would have the same time (to the second) but the
marker would have some microseconds more than t.created\_at, so the
assertion would fail.  
  
The Ruby documentation actually warns you about this, but in way that's
cryptic enough that it might not be obvious why your simple test case is
failing in such a bizarre way.  
  
The solution? Mine was make the time an integer and convert it back to a
time using Time.at:  
<pre>marker = Time.at(Time.now.to\_i)  
t.create(args)  
assert t.created\_at.between?(marker, Time.now)</pre>This doesn't really
merit a blog post, except that I Googled for solutions to the problem
and didn't find much.

