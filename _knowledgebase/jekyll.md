---
title: Jeykyll Cheat Sheet
layout: kb
toc: true
---

## Directories

* `_site` This is where Jekyll puts your compiled site. It's what you send to the public facing server(s) when you deploy.
* `.` (dot -- the top-level directory of your project) Jekyll copies files from the root of your project into `_site`. There is an exclude list in `config.yml`.
* `---(.*\n)+---` causes Jekyll to process Liquid in the file.
* `_layouts` is where you put layouts. `layout: _filename_` in the front matter to use a layout. `{% raw %}{{ content }}{% endraw %}` to interpolate the page content in the layout.
* `_includes` is where you put files to include. `{% raw %}{% include _filename_ %}{% endraw %}` to include the include file in a page or layout.
* `_data` stores `.yml` files that can hold data you can access from Liquid tags. `{% raw %}{{ site.data._filename_._key_ }}{% endraw %}`.
* `assets` stores assets, typically in `css`, `images`, and `js`.

    * Put a Sass file in `assets/css` that has all your `@import`s.

* `_assets` (no possibility of confusion here.)

    * Put the imported Sass files here.

* `_posts` is for blog posts. The special file name that includes the publish date is significant. `yyyy-mm-dd-_title_.md`.
* Add `jekyll-sitemap` and `jekyll-feed` to the `Gemfile` for a site map, and to generate an RSS feed. See the [docs](https://jekyllrb.com/docs/step-by-step/10-deployment/#plugins). Add `{% raw %}{% feed_meta %}{% endraw %}` to get the RSS feed.

## Miscellaneous

* `{% raw %}{{ page.title | smartify }}{% endraw %}`

## Sass

With CSS or Sass part of an npm package, you need to add the following to your `_config.yml`:

```yml
sass:
  load_paths:
    - _sass
    - node_modules
```

## Docker

* Use `lenchoreyes/jade:rails-app-3.3-bookworm` with a simple `compose.yml`:

```yml
{% include compose.yml %}
```
