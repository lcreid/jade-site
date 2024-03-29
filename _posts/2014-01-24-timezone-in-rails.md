---
layout: post
title: Time Zone in Rails
date: '2014-01-24T21:34:00.001-08:00'
author: Larry Reid
tags:
- Ruby on Rails
modified_time: '2014-01-27T10:17:23.785-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3989272479150130365
blogger_orig_url: http://technopragmatica.blogspot.com/2014/01/timezone-in-rails.html
---

There’s pretty good info out there about using time zones in Rails, and
Rails itself does a lot of the heavy lifting. The [Railscast][1] pretty
much covers it. It’s only missing a discussion of using Javascript to
figure out the client browser’s time zone.

<div class="se-section-delimiter"></div>
<h1 id=\"time-zone-from-the-browser\">Time Zone from the Browser</h1>
To get
the time zone from the browser, use the [detect_timezone_rails][2]
gem. The instructions give you what you need to know to set up a form
with an input field that will return the time zone that the browser
figured out. That would work perfectly if you were implementing a
traditional web site sign-up/sign-in form.

However, I needed to do something different. Since I’m using third party
identity providers (Google, Twitter, Facebook, etc.) via the excellent
[Omniauth][3] gems, I needed to be able to put the time zone as a
parameter on the URL of the identity provider’s authorization request.
Omniauth arranges for that parameter to come back from the identity
provider, so it’s available to my app’s controller when I set up the
session.

To add the parameter, I added this jQuery script to the head of the
welcome page:

```html
<script type="text/javascript">
  $(document).ready(function () {
    $('a.time_zone').each(function () {
      this.href =
        this.href + "?time_zone=" +
        encodeURIComponent($().get_timezone());
    });
  });
</script>
```

This added the time zone, appropriately escaped, to
the URL for the identity provider (the href of the `<a>` elements). This
worked because I had set each of the links to the identity providers to
have `class="time_zone"`, like this:

```erb
<%= link_to image_tag("sign-in-with-twitter-link.png", alt: "Twitter" ), "/auth/twitter" , class: "time_zone" %>
```

In the controller, I did this (along with all the other logging in stuff):

```ruby
if env['omniauth.params'] && env['omniauth.params']['time_zone']
  tz = Rack::Utils.unescape(env['omniauth.params']['time_zone'])
  if user.time_zone.blank?
    user.time_zone = tz
    user.save!
    flash.notice = "Your time zone has been set to #{user.time_zone}." +
                   " If this is wrong," +
                   " please click #{view_context.link_to('here', edit_user_path(user))}" +
                   " to change your profile."
  elsif user.time_zone != tz
    flash.notice = "It appears you are now in the #{tz} time zone." +
      " Please click #{view_context.link_to(edit_user_path(user), 'here')}" +
      " if you want to change your time zone."
  end
else
  logger.error("#{user.name} (id: #{user.id}) logged in with no time zone from browser.")
end
```

Of course, you may want to do something different in your
controller.

<h1 id=\"testing-time-zones\">Testing Time Zones</h1>

However you get your
time zones, you need to be testing your app to see how it works with
different time zones. YAML, at least for a Rails fixture, interprets
something that looks like a date or time as UTC. So by default, that’s
what you’re testing with. But that might not be the best thing.

I had read that a good trick for testing is to pick a time zone that
isn’t the one your computer is in. Finding such a time zone might be
hard if you have contributors around the world. I like the Samoa time
zone for testing: Far away from UTC, not too many people living in the
time zone, and it has DST.

If you want a particular time zone in your fixtures, you have to use
ERB. For example, in my fixtures I might put this:

```
created_at: <%= Time.find_zone('Samoa').parse('2014-01-30T12:59:43.1') %>
```

And in
the test files, something like this:

```ruby
test 'routines layout' do
  Time.use_zone('Samoa') do
    expected = Time.zone.local(2014, 1, 30)
    # ...
  end
end
```

<h1 id=\"gotchas\">Gotchas</h1>

I found a few gotchas that I hadn’t seen mentioned elsewhere:

* Rails applies the time zone magic when it queries the database, so if you change your time zone after you retrieve the data, then you have to force a requery, or the cached times will still be in the model. Shouldn’t be a problem when running tests, but is when using the console to figure things out
* You can’t use database functions to turn times into dates, as these won’t use the time zone. No `group by to_date(...)` or anything like that

[1]: http://railscasts.com/episodes/106-time-zones-revised
[2]: https://github.com/scottwater/detect_timezone_rails
[3]: http://intridea.github.io/omniauth/
