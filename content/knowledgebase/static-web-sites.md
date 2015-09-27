---
title: Static Web Sites
---

# Static Web Sites
A previous version of the Jade Systems web site was built with [Drupal](http://drupal.org). Drupal is a fine content management system. But with all the capability comes complexity, and with complexity, inevitably, security issues. Drupal provides frequent security updates, but I have other work to do, and updating my web site's content management system was becoming a drag.

For years I thought there had to be a different way. Many web sites don't need to be interactive. They certainly don't need all the functionality in a general purpose content management system. Web sites that have as a main goal to provide information, like wikis and blogs, don't need to be interactive. Marketing sites are another example. A corporate knowledge base would be a perfect candidate.

Even for those simple types of sites, however, using basic HTML and CSS while trying to maintain a consistent look and feel across pages means a lot of repetition. That's a different kind of maintenance nightmare I also didn't want to deal with.

I tried the "web site as a service" offerings, like [Google Sites](https://sites.google.com). They didn't work for me, because I wanted a little more control over what I was doing, and the option to deploy sites wherever I wanted. However, if you're new to building web sites, they're definitely worth considering. My wife, with no programming experience at all, built a web site for [her sister's clinic](https://sites.google.com/site/veterinariasantarita/) all by herself.

About the same time as I was getting tired of doing Drupal updates, I stumbled across another interesting perspective from [Thoughtworks](http://thoughtworks.com). [Martin Fowler](http://martinfowler.com) describes an [architecture for a custom content management system](http://martinfowler.com/articles/two-stack-cms/). Their approach was to build the site on one platform, and compile it into code to be run on the platform that actually served up the web site content.

So I got serious about looking into static web sites.

## Static Web Site Generators
45 seconds with Google showed me that lots of people have been working on static web site generators. Check out this page of [static web site generators](https://www.staticgen.com/).

I picked [Nanoc](http://nanoc.ns) because my Ruby experience was transferable.

With Nanoc you define templates and content, and it compiles them into a static web site using only HTML, CSS, and JavaScript. It lets you define content and include the content in multiple places, so you don't have to worry about repetition.

Nanoc also takes advantage of Ruby's extensive eco-system of software. For example, you can write your content in [Markdown](http://http://daringfireball.net/projects/markdown/), and configure Nanoc to convert it to HTML.

## Pros and Cons of Static Sites
A static site is much easier to make secure. If you have control over the web server software itself, you can turn off all its ability to execute code on the server, and make it only serve up static content. Aside from keeping your operating system and web server software up-to-date, you're pretty much secure. No more constant updates of a large, complicated content management system.

A static site will be supported by any hosting service. Nowadays that's not such a big issue -- most cheap hosting services provide Drupal and other content management systems. However, if your preference is for other technologies, you may be able to find a static web site generator based on those technologies.

A static web site generator can be easier to learn, if you're already familiar with HTML, CSS, and JavaScript. This can vary according to the specific web site generator, so it's worth looking in to. For example, with Nanoc you can easily set things up so the majority of people producing content only need to know Markdown, with just a few providing the rest of the presentation via HTML and CSS.

If you're not already familiar with HTML, CSS, and JavaScript, then you want to look for a static web site generator that operates at a more friendly level, or one of the "web site as a service" offerings, like Google Sites.

Some static web site generators, like Nanoc, are built from text files. This makes it very easy to track changes to your web site, if you're used to using version control software like Git or Subversion. And of course you're free to use whichever tool you know and prefer.

Also because a static site is composed of HTML, CSS, and JavaScript files, backup of your web site is much easier. If you have your site in a version control system, that may be enough backup for you. If you don't, you can back up your whole site the same way you do any other files on your computer. Content management systems typically store some of the site definition as files, and some as database tables. To back up your site, you have to back up the files, and also back up the database, and try to keep the two in sync. It's hard enough for most people to get motivated to do backups. When backups become complicated, no one wants to do them.

I keep my sites on Github, so I always have a backup and a complete history of changes to the site.

Obviously, there's a lot you can't do with a static site. You're not going to build an advanced shopping site, or a forum, or the next Facebook. You're not going to be able to store any data that comes from the user.

Even then, a static web site doesn't have to mean a simple web site. As JavaScript and browsers mature, we're putting more and more functionality back into the user's device. By combining a static web site with strategic calls to simple APIs, you can build sites that combine rich functionality, version control, backups, and robust security.

A simple example is <%= link_to("how I added search", "/knowledgebase/search-engines/") %> to Jade's web site. I put up a search engine on a different server, and wrote JavaScript to call the search engine from the web site, in the client's browser.

## When to Use a Static Site
Here are my ideas about when to consider using a static web site. The more often you answer "yes" to the following, the more likely you have a good fit for a static site:

* The people creating content are comfortable with basic HTML, and some are comfortable with CSS and JavaScript
* Version control of the web site is important
* You don't need to collect information from visitors to the web site
* The web site is relatively simple. Or it's completely the opposite of simple, and you're looking for tools to incorporate into a custom workflow process for building and modifying a large, complicated web site
* Hosting of the site needs to be low-maintenance
* The site needs to be secure
* You want to host your own site, for example, if your content is sensitive and for legal or business reasons you need to keep it in house
