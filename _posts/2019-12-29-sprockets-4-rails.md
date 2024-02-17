---
layout: post
title: Sprockets 4, or Rails Assets Missing
author: Larry Reid
tags:
---

At some point upgrading an existing Rails application, you're going to pull in Sprockets 4.
(Not the `sprockets-rails` gem. The actual `sprockets` gem.)
At this point, your assets will probably fail to compile.

The quickest fix for this that I've found (without forcing an old Sprockets version in your `Gemfile`) is to change the `app/assets/config/manifest.js` file to:

```javascript
//= link_tree ../images
//= link application.css
//= link application.js
```

This solutions may have implications as you move to using the features of the new asset pipeline (or Webpacker),
but that's a bigger topic than I want to tackle in this post.
