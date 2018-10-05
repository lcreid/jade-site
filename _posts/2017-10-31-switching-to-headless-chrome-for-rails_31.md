---
layout: post
title: Switching to Headless Chrome for Rails System Tests
date: '2017-10-31T19:10:00.001-07:00'
author: Larry Reid
tags:
modified_time: '2017-10-31T19:14:02.829-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-3961851211874154607
blogger_orig_url: http://technopragmatica.blogspot.com/2017/10/switching-to-headless-chrome-for-rails_31.html
---

## Introduction
I recently switched a Rails 5.1 application's system tests from [Capybara](https://github.com/teamcapybara/capybara), [Poltergeist](https://github.com/teampoltergeist/poltergeist), and [PhantomJS](http://phantomjs.org/), to Capybara, Selenium, and headless Chrome. We run the development and test environments of the application on a Vagrant box running Ubuntu 16.04 server.

With the release of headless Chrome, [PhantomJS is no longer being developed or maintained](https://github.com/ariya/phantomjs/issues/15105). It also used a different browser engine that the major browsers, and I was noticing that some test cases didn't run exactly like they would in a real browser. So when I saw that there was a [pull request](https://github.com/rails/rails/pull/30930) in to Rails to change to Selenium and headless Chrome, I thought it was time to try it myself.

## Installation

The first thing I did was to install Google Chrome from a Google repository, so it's easy to get updates:

```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## Configuration
(Note that this configuration will change if/when [Rails comes with configuration for headless Chrome](https://github.com/rails/rails/pull/30930).)

I set up the configuration in `test/application_system_test_case.rb`. The Rails 5.1 `driven_by` allows some options to be set, but I couldn't figure out how to set the options I needed, so I registered a separate driver for headless Chrome:

```
  Capybara.register_driver(:headless_chrome) do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      # This makes logs available, but doesn't cause them to appear
      # in real time on the console
      loggingPrefs: {
        browser: "ALL",
        client: "ALL",
        driver: "ALL",
        server: "ALL"
      }
    )

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("window-size=1400,1200")
    options.add_argument("headless")
    options.add_argument("disable-gpu")

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: capabilities,
      options: options
    )
  end

  driven_by :headless_chrome
```

The arguments for `"headless"` and `"disable-gpu"` were necessary to make testing with headless Chrome work. I had to set the window size, because the default window size caused my application's menu to collapse to a mobile device menu (I'm using Bootstrap 4).

## Upgrade Capybara
My 	`Gemfile` had the version of Capybara locked down. I found that a lot of problems went away simply by taking away the version constraint in the `Gemfile` and letting `bundle upgrade capybara --conservative` do its thing.

## `fill_in` Doesn't Fire Change Event
I had some JavaScript that ran when input fields changed, via the `changed` event. I had to add a newline to the end of the input text for force the change event to fire:
```
fill_in "Fragment", with: "Outage B\n"
```

## `fill_in` Date Time Field With `""` Doesn't Work
Filling in a date time field with `""` to clear it worked with Poltergeist/PhantomJS. With Selenium and headless Chrome it gives:
```
Selenium::WebDriver::Error::InvalidElementStateError: invalid element state: Element must be user-editable in order to clear it.
```
So I changed the places where I had to clear a date or date time field to this instead:
```
find_field("Outages Before").send_keys :delete
```

## `fill_in` Date Field With Date Works Differently
Selenium and headless Chrome seem to process `fill_in` of a date field more like what the user would experience. My tests that worked with Poltergeist and PhantomJS didn't work with headless Chrome and Selenium, although part of the problem may have been with the `change` event triggers I had on the date fields.

I got the tests to work by (mysteriously) entering the date as "12312017", in other words, in the date order used by only one country in the whole known universe. I still had to assert against dates in the format "yyyy-mm-dd".

I also discovered that PhantomJS and/or Poltergeist was more forgiving about date formats in asserts, so I had to change a bunch of asserts where I had used the "dd/mm/yyyy" format.

## Alerts
Alerts aren't automatically dismissed, so I had to go through all my tests and put an `assert_accept` block around actions like deletes, like this:

```
accept_alert do
  click_link "Delete"
end
```

## Empty `div`s
Selenium and Chrome seem to treat an empty `div` as if it's not visible. I had to change some selectors that were looking for an empty `div` to something like this:

```
assert_selector ".test-home-page", visible: :any
```

## No Browser Logs in Real Time (or by Default)
Browser logs don't appear by default, and don't appear in real time. To show what was in the browser log, I had to put the following in the test script [Edit: The following has changed since I originally wrote this]:
```
puts page.driver.browser.manage.logs.get(:browser)
```
To even have the browser log available at all, I had to set up the configuration as described at the beginning of this post.

## Performance
My system tests take about 50 % longer with headless Chrome, compared to PhantomJS.
