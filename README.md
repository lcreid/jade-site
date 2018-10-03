jade-site
=========

Jade Systems Inc web site.

## Putting it Together
This is the third implementation of the modern site, in [Jekyll](https://jekyllrb.com).

Need [`jekyll-assets` gem](https://github.com/envygeeks/jekyll-assets). It's quite confusing what I'm actually going to get with it, but the basics seems to imply a Sprockets-based asset pipeline, which is attractive, because I can then simply include the [`boostrap-rubygem`](https://github.com/twbs/bootstrap-rubygem).

I made an `assets/css` folder and put the `application.scss` in it. It got built, but not included because it was built to the new location. Had to specify the `sass_dir` to be `assets/css` in `_config.yml` and put all the SASS files in `assets/css`.

[Get Bootstrap](https://github.com/twbs/bootstrap/archive/v4.1.3.zip).
