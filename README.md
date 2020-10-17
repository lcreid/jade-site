# jade-site

Jade Systems Inc web site.

## Development

This is the third and a half implementation of the modern site, in [Jekyll](https://jekyllrb.com).
We now prefer to use Docker for the Jekyll part.

With Docker, just use a standard Docker Jekyll container:

```bash
JEKYLL_VERSION=3.8.4
docker run -p 4000:4000 --volume="$PWD:/srv/jekyll" -it jekyll/jekyll:$JEKYLL_VERSION jekyll serve
```

### This will change soon

Need [`jekyll-assets` gem](https://github.com/envygeeks/jekyll-assets). It's quite confusing what I'm actually going to get with it, but the basics seems to imply a Sprockets-based asset pipeline, which is attractive, because I can then simply include the [`boostrap-rubygem`](https://github.com/twbs/bootstrap-rubygem). [Yes. I just had to use `bootstrap-rubygem`.]

I made an `assets/css` folder and put the `application.scss` in it. It got built, but not included because it was built to the new location. Had to specify the `sass_dir` to be `assets/css` in `_config.yml` and put all the SASS files in `assets/css`.

Once I had that figured out, I just removed the link to Bootstrap from the CDN, and added `@import "bootstrap";` to the end of `application.scss`. It took a few heartbeats to compile, but then everything was fine.

Oops. It looks like I should have put the source SASS in `_assets`.

Okay. Now on to Javascript. Using the Rails gem (`jquery-rails`) didn't seem to work, but simply copying the `jquery-3.1.1.js` file into the `_assets/js` directory and changing its name to `jquery3` seems to have worked. (I could have also changed the file name in `application.js` instead).

Using the [importer](https://import.jekyllrb.com/docs/blogger/) to get all the blog posts from blogger was pleasantly easy. Figuring out how to show them in anything other than a long list is still an unsolved problem. The `jekyll-archives` gem solves some of the problem, but it didn't seem to really be what I wanted, so I dropped it for now. The Jekyll documentation shows a variety of examples of various approaches. This may be one of those problems that are general enough that a gem or plug-in isn't a useful approach.

### TODO

Simplify deploy, as I don't need Capistrano, really.
Just do the right `rsync`.
