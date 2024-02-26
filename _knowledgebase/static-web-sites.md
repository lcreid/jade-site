---
title: Static Web Sites
layout: kb
toc: true
---

## Static Web Sites

A previous version of the Jade Systems web site was built with [Drupal](http://drupal.org). Drupal is a fine content management system. But with all the capability comes complexity, and with complexity, inevitably, security issues. Drupal provides frequent security updates, but I have other work to do, and updating my web site's content management system was becoming a drag.

For years I thought there had to be a different way. Many web sites don't need to be interactive. They certainly don't need all the functionality in a general purpose content management system. Web sites that have as a main goal to provide information, like wikis and blogs, don't need to be interactive. Marketing sites are another example. A corporate knowledge base would also be a good candidate for a static site.

Even for those simple types of sites, however, using basic HTML and CSS while trying to maintain a consistent look and feel across pages means a lot of repetition. That's a different kind of maintenance nightmare I also didn't want to deal with.

I tried the "web site as a service" offerings, like [Google Sites](https://sites.google.com). They didn't work for me, because I wanted a little more control over what I was doing, and the option to deploy sites wherever I wanted. However, if you're new to building web sites, they're definitely worth considering. My wife, with no programming experience at all, built a web site for [her sister's clinic](https://sites.google.com/site/veterinariasantarita/) all by herself.

About the same time as I was getting tired of doing Drupal updates, I stumbled across another interesting perspective from [Thoughtworks](http://thoughtworks.com). [Martin Fowler](http://martinfowler.com) describes an [architecture for a custom content management system](http://martinfowler.com/articles/two-stack-cms/). Their approach was to build the site on one platform, and compile it into code to be run on the platform that actually served up the web site content.

So I got serious about looking into static web sites.

## Static Web Site Generators

45 seconds with Google showed me that lots of people have been working on static web site generators. Check out this page of [static web site generators](https://www.staticgen.com/).

Around 2012, I picked [Nanoc](http://nanoc.ns). In part because my Ruby experience was transferable. In part because a lot of serious sites used it.

With Nanoc you define templates and content, and it compiles them into a static web site using only HTML, CSS, and JavaScript. It lets you define content and include the content in multiple places, so you don't have to worry about repetition.

Nanoc also takes advantage of Ruby's extensive eco-system of software. For example, you can write your content in [Markdown](http://http://daringfireball.net/projects/markdown/), and configure Nanoc to convert it to HTML.

Nanoc did a fine job for me for a about five years, but I've moved on to [Jekyll](https://jekyllrb.com/) now. Jekyll is widely used, in part, I'm sure, because it's the technology of [Github Pages](https://pages.github.com/). It has more resources supporting it and the larger user base means they're forced to keep the platform a little more stable. It uses Liquid instead of ERB for programmatically generating parts of a page, but so far I've found that hasn't been too much to learn.

In the end, what really drove me off Nanoc was the fact that every time I went to update my website, it seemed there were breaking changes in the platform. For a tool that I used occasionally, having to re-learn it every time I went to use it means the cost to switch to another platform was low. I can't fault the creator of Nanoc. He does a great job with limited resources. If I were using Nanoc every day and was keeping up with it as it evolved, I probably never would have switched to Jekyll.

## Pros and Cons of Static Sites

A static site is much easier to make secure. If you have control over the web server software itself, you can turn off all its ability to execute code on the server, and make it only serve up static content. Aside from keeping your operating system and web server software up-to-date, you're pretty much secure. No more constant updates of a large, complicated content management system.

A static site will be supported by any hosting service. Nowadays that's not such a big issue -- most cheap hosting services provide Drupal and other content management systems. However, if your preference is for other technologies, you may be able to find a static web site generator based on those technologies.

A static web site generator can be easier to learn, compared to a content management system, if you're already familiar with HTML, CSS, and JavaScript. This can vary according to the specific web site generator, so it's worth looking in to. For example, with Nanoc or Jekyll you can easily set things up so the majority of people producing content only need to know Markdown, with just a few providing the rest of the presentation via HTML and CSS.

If you're not already familiar with HTML, CSS, and JavaScript, then you want to look for a static web site generator that operates at a more friendly level, or one of the "web site as a service" offerings, like Google Sites.

Some static web site generators, like Nanoc and Jekyll, are built from text files. This makes it very easy to track changes to your web site, if you're used to using version control software like Git or Subversion. And of course you're free to use whichever version control tool you prefer.

Also because a static site is composed of HTML, CSS, and JavaScript files, backup of your web site is much easier. If you have your site in a version control system, that may be enough backup for you. If you don't, you can back up your whole site the same way you do any other files on your computer. Content management systems typically store some of the site definition as files, and some as database tables. To back up your site, you have to back up the files, and also back up the database, and try to keep the two in sync. It's hard enough for most people to get motivated to do backups. When backups become complicated, no one wants to do them.

I keep my sites on Github, so I always have a backup and a complete history of changes to the site.

Obviously, there's a lot you can't do with a static site. You're not going to build an advanced shopping site, or a forum, or the next Facebook. You can't even keep comments (although you could use a service like [Disqus](https://disqus.com/) for that.) You're not going to be able to store any data that comes from the user.

Even then, a static web site doesn't have to mean a simple web site. As JavaScript and browsers mature, we're putting more and more functionality back into the user's device. By combining a static web site with strategic calls to simple APIs, you can build sites that combine rich functionality, version control, and backups.

If you're using APIs that require authentication, you'll have to think about managing the token that gives you access to the API. Anything on a page is visible to a user that knows how to press F12 in the browser. APIs that provide a [JSON web token](https://en.wikipedia.org/wiki/JSON_Web_Token) (JWT) would be suitable for calling from a static web site.

A simple example of using an API is [how I added search]({{ site.baseurl }}{% link _knowledgebase/search-engines.md %}) to Jade's web site. I put up a search engine on a different server, and wrote JavaScript to call the search engine from the web site, in the client's browser.

If the static web site is to be updated by many people (as opposed to just a single person maintaining a personal blog), the tools I've used don't solve all the workflow issues. I'm using Capistrano to push changes, because it's a tool I'm familiar with and I have it all set up already for other sites I manage. The flexibility around the workflow is good and bad: Good, because you can use tools you're already using. Bad, because you may have to find new tools, and you have to train the team on how to use them.

## When to Use a Static Site

Here are my ideas about when to consider using a static web site. The more often you answer "yes" to the following, the more likely you have a good fit for a static site:

* The people creating content are comfortable with basic HTML, and some are comfortable with CSS and JavaScript
* Version control of the web site is important
* You don't need to collect information from visitors to the web site
* The web site is relatively simple. Or it's completely the opposite of simple, and you're looking for tools to incorporate into a custom workflow process for building and modifying a large, complicated web site
* Hosting of the site needs to be low-maintenance
* The site needs to be secure
* You want to host your own site, for example, if your content is sensitive and for legal or business reasons you need to keep it in house
