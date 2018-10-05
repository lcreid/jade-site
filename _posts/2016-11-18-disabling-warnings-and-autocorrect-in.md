---
layout: post
title: Disabling Warnings and Autocorrect in Rubocop
date: '2016-11-18T06:53:00.001-08:00'
author: Larry Reid
tags:
modified_time: '2016-12-23T08:19:40.046-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-756460110180333998
blogger_orig_url: http://technopragmatica.blogspot.com/2016/11/disabling-warnings-and-autocorrect-in.html
---

I finally found how to disable Rubocop messages and auto-correction on a file or individual line basis.

I have Atom set up to run Rubocop and auto-correct my files on save. Most of the time this is very handy. I especially like how most of the time it indents my code to the standard. But I was struggling to debug some test cases, and I wanted to use Capybara's  `save_and_open_page` to see what Capybara was actually looking at. When I saved the file, Rubocop and Atom helpfully deleted the line before I could even run the test case.

But then I discovered this:
```
save_and_open_page # rubocop:disable Lint/Debugger
```
Problem solved.

Since the `Lint/Debugger` cop is arguably not applicable to your test files, I sometimes put this at the top of a test file:
```
# rubocop:disable Lint/Debugger
```
In the above case, I could turn Rubocop back on if I needed it with:
```
# rubocop:enable Lint/Debugger
```
This is described in the manual at [http://rubocop.readthedocs.io/en/latest/configuration/#disabling-cops-within-source-code](http://rubocop.readthedocs.io/en/latest/configuration/#disabling-cops-within-source-code), but I had trouble finding that section with Google.
