# jade-site

Jade Systems Inc web site.

## Development

This is the third and a half implementation of the modern site, in [Jekyll](https://jekyllrb.com).
We now prefer to use Docker in development for the Jekyll part.

With Docker, just use a standard Docker Jekyll container:

```bash
JEKYLL_VERSION=4.1 # Or whichever version you want
docker run -p 4000:4000 --volume="$PWD:/srv/jekyll" -it jekyll/jekyll:$JEKYLL_VERSION jekyll serve
```

If you're doing Jekyll upgrades or anything else that requires experimenting with new gems, you may find it more convenient to start a shell in the container and run `jekyll serve` from there.
This lets you quit the server and install or remove the gems you want, without restarting the container, which has to re-install _all_ the gems.
Even with a minimal set of gems, `bundle install` from scratch for jekyll takes enough time to be annoying.

To deploy:

```bash
rsync -r _site/ jadesystems.ca:/var/www/jadesystems.ca/html
```

### This won't change. Historical info

Using the [importer](https://import.jekyllrb.com/docs/blogger/) to get all the blog posts from blogger was pleasantly easy. Figuring out how to show them in anything other than a long list is still an unsolved problem. The `jekyll-archives` gem solves some of the problem, but it didn't seem to really be what I wanted, so I dropped it for now. The Jekyll documentation shows a variety of examples of various approaches. This may be one of those problems that are general enough that a gem or plug-in isn't a useful approach.

## Historical Development NOtes

* January, 2021, removed the search coffescript.

