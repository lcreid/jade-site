---
layout: post
title: Tips for System Testing With Capybara
date: '2017-10-14T11:35:00.001-07:00'
author: Larry Reid
tags:
modified_time: '2017-10-14T11:37:59.838-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6412848945539808114
blogger_orig_url: http://technopragmatica.blogspot.com/2017/10/tips-for-system-testing-with-capybara_37.html
---
One of the great challenges of system testing applications is the fact that there are two (or more) independent processes: One to run the test script. The other to run the browser. The actions in the test script and the actions as performed by the browser and the back end, are not necessarily synchronized the way they are in unit or controller tests.

This can lead to tests the fail sometimes but not others. They may fail one in ten runs, or they may work on development machines, but fail on the continuous integration platform, or vice versa. [Some say](https://martinfowler.com/articles/nonDeterminism.html) that unreliable tests are one of the key things that lead people away from automated testing.

I've struggled with unreliable tests on Rails applications using [Capybara](http://teamcapybara.github.io/capybara/). Here are some of the solutions I've used successfully to make tests more reliable.

## Spinner
I like this one because it's what I should be doing for my users anyway. Anytime something is happening in the background that might take some time, the page should put up a spinner -- something that shows that the user should wait.

There are lots of spinners available on-line. Some examples are:

* https://projects.lukehaas.me/css-loaders/
* http://cssload.net/en/spinners
* https://www.pexels.com/blog/css-only-loaders/ (the example below is based on the snake spinner from this link)

The spinner chosen is not important from the point of view of the test. The tests work on the presence or absence of the spinner element. The basic idea is this:

1. The Capybara test script initiates a JavaScript action that will take some time
2. The test browser begins running the JavaScript. The first thing the JavaScript does is put up the spinner by un-hiding the spinner element or adding the spinner element to the DOM. The spinner element should have a distinctive id or class
3. The Capybara script waits for the spinner to go away by doing something like:
    ```
    assert_no_selector ".spinner"
    ```
4. On completing the AJAX request, the JavaScript hides the spinner element or removes it from the DOM

Here is one example of this technique from a Rails 5.1 application with Turbolinks. All it needs is this JavaScript in the application:

```JavaScript
$(document).on('turbolinks:load', function(e) {
  $('form.js-submit-on-change').change(function(event) {
    $("body").prepend('<div class="spinner"></div>');
    $(this).submit();
  }).on("ajax:success", function(e) {
  }).on("ajax:error", function(e) {
  }).on("ajax:complete", function(e) {
    $(".spinner").remove();
  });
});
```

And then this in the test case to ensure that the test is synchronized with the browser:
```Ruby
assert_no_selector ".spinner"
```

(This JavaScript works for the case where I had forms that I wanted to automatically submit on any change to any of their fields. A traditional form that has a submit button would want to catch the submit event for the form.)

For completeness, here's some SASS to put in `assets/stylesheets/spinner.scss` to actually show a spinner:
```CSS
.spinner {
  @extend .centered-in-window;
  z-index: 1;
  height: 64px;
  width: 64px;
  animation: rotate 1s infinite linear;
  -webkit-animation: rotate 1s infinite linear;
  border: 8px solid #fff;
  border-right-color: black;
  border-radius: 50%;
}

@keyframes rotate {
  0% {
    transform: rotate(0deg);
  }

  100% {
    transform: rotate(360deg);
  }
}

@-webkit-keyframes rotate {
  0% {
    -webkit-transform: rotate(0deg);
  }

  100% {
    -webkit-transform: rotate(360deg);
  }
}

.centered-in-window {
  position: fixed;
  top: 50%;
  left: 50%;
  /* bring your own prefixes */
  transform: translate(-50%, -50%);
}
```

Don't forget to add `@import "spinner";` to your `assets/stylesheets/application.scss` file.

## Only the Back End Changes
When the user changes, say, a check box or a drop down menu (a select tag), nothing happens on the browser side other than the change the user made. But often, on the back end something is added, changed, or removed from the database. I tried to use Rails' `assert_difference` to test that the right thing happened, but more often than not it would fail, because by the time the database was updated, Capybara had already finished executing the `assert_difference`.

Because of that, my tests were full of examples like this:
```Ruby
assert_difference "CisOutage.count" do
  click_on "Save"
  sleep 2
end
```

Each time I put in a `sleep 2` in my test cases, I was making the test take almost two seconds longer than it needed to. If I didn't have the `sleep 2` in the test, the test would fail, because the `CisOutage` record wouldn't have been saved in the database by the time the test case evaluated the `CisOutage.count`.

To fix this, I wrote my own `assert_difference` for system tests, shamelessly stealing from the Rails source and a few items from Capybara. Like the Rails `assert_difference`, it runs the expressions to get the "before" value, executes the block, then runs the expressions again to get the after values. Unlike the Rails version, if any of the expressions fail to produce the desired result, it sleeps for a tenth of a second, then retries the expressions, until all the expressions produce the desired result, or two seconds pass:

```Ruby
##
# Check for a difference in `expression`, but repeat the check until it's
# true, or two seconds pass. Taken from Rails source and leveraging
# some Capybara stuff.
def assert_difference(expression, difference = 1, message = nil, &block)
  expressions = Array(expression)

  exps = expressions.map do |e|
    e.respond_to?(:call) ? e : -> { eval(e, block.binding) }
  end
  before = exps.map(&:call)
  after = []

  retval = yield

  start_time = Capybara::Helpers.monotonic_time
  loop do
    after = exps.map(&:call)
    break if before.zip(after).all? { |(b, a)| a == b + difference } ||
             start_time + 2 < Capybara::Helpers.monotonic_time
    sleep 0.1
  end

  expressions.zip(after).each_with_index do |(code, a), i|
    error  = "#{code.inspect} didn't change by #{difference}"
    error  = "#{message}.\n#{error}" if message
    assert_equal(before[i] + difference, a, error)
  end

  retval
end
```

For Rails 5.1, I put this in the `ApplicationSystemTestCase` class in `app/test/application_system_test_case.rb`. For Rails 5.0 and 4.x, I would have to put it somewhere else.

This code could be improved in many ways, but it was good enough to allow me to remove 40 seconds worth of arbitrary `sleep` statements in my system test cases.

Now my test case looks like this:
```Ruby
assert_difference "CisOutage.count" do
  click_on "Save"
end
```
And the test typically waits at most a couple of tenths of a second before succeeding.

## Only the Order Changes
To test "latest first/earliest first" buttons, and similar actions, I had to go beyond a simple `assert_text` on the page. At first I tried getting all the list items within the list I was interested in, like this:

```Ruby
click_link "Oldest First"
notes = all("li.note")
within(notes[0]) do
  assert_text "Note B"
  assert_text "1 day ago"
  assert_no_link "Edit"
  assert_text "Can Edit CIs/Outages"
end
```

This would fail if Capybara happened to grab the list *before* the back end had replied to the browser. More often than not, I found Capybara would populate the `notes` variable with nodes from the page *before* the back end responded with the re-ordered list. In the best case, I would simply get test failures. In other cases, Capybara would actually throw errors (the dreaded "stale node" error). This is because once the browser gets the response from the back end, the nodes in `notes` will no longer be on the current page of the browser.

My fix was to use a more specific selector to take advantage of [Capybara's waiting behaviour](http://www.rubydoc.info/github/teamcapybara/capybara#asynchronous-javascript-ajax-and-friends). This method works for one specific case I had:
```Ruby
  def assert_synchronized(text, ordinal = 0)
    assert_selector "li.note:nth-of-type(#{ordinal + 1}) .note-body", text: text
  end
```
This finds the `(ordinal + 1)`th list item, and then if it has class `note`, finds all nodes with class `note-body` with the `li`, and checks to see if they have the desired text.

When I put this `assert_synchronized` call somewhere in the test case, Capybara checks that the first item in the list has the text I expect, and will do its standard waiting behaviour before proceeding with the rest of the test.

I was using 0-based indexes in the rest of the code, but CSS selectors are 1-based, which is why the `ordinal + 1`. Also, in a more general case I'd have to make sure I was in the right list, but on this page there was only one list. The actual selector would be different for every page or case. The above is just one example.

Here's how I fixed the above test case:

```Ruby
click_link "Oldest First"
assert_synchronized("Note B")
notes = all("li.note")
within(notes[0]) do
  assert_text "Note B"
  assert_text "1 day ago"
  assert_no_link "Edit"
  assert_text "Can Edit CIs/Outages"
end
```

I ran into a couple of challenges with this approach:

* The `nth-of-type(x)` selector is literally on the type, AKA HTML tag, and not the other selectors. In other words, something like `li.note:nth-of-type(1)` gets the first `li` regardless of its classes, then checks to see if the `li` has class `note`. So if the list is mixed and the first `li` does not have class `note`, the selector returns nothing
* I had a mixed list as described above, where not every `li` had the same class. To work around the problem, I was looking at the second item in the list. But the list only had three items in it, so looking at the second item wasn't synchronizing Capybara with the back end. It took me a while before the light bulb when on and I realized why my test was getting out of sync
