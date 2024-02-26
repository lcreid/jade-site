---
title: Search Engines
layout: kb
---

## Search Engines

I wanted to make the [Jade Systems site](https://jadesystems.ca) searchable. No problem, I thought. There's lots of open source tools out there. My main goal was to have the sort of intelligent searching the Google does. People have been used to not having to worry about plural versus singular, or synonyms, or a myriad of other linguistic variations that don't really change the intent or semantics of a search.

After some searching, I settled on [Solr](http://lucene.apache.org/solr/) for the searching, and [Nutch](http://nutch.apache.org/) for the crawling and creating of the index. The main reason I chose them was probably that as Apache Foundation projects, they were clearly licensed for my use, and weren't likely to suffer a change in licensing.

After some non-trivial effort, I created a [search engine Vagrant box](https://github.com/lcreid/solr-nutch-vagrant) that would run a crawl and search engine. This let me test and learn about searching in my own network. I could index my static web site (generated at the time with Nanoc, but since migrated to Jekyll) with Nutch and then have the static web site query the search engine and display results.

When that was all working, I used the Vagrant provisioning scripts to create a stand-alone VM that I ran on my basement server. I set some forwarding on my router to let traffic through, and deployed my web site to a server. This worked relatively well, as long as my home IP didn't change.

A year or two later, along came [Let's Encrypt](https://letsencrypt.org/), and now it was practical to apply HTTPS to the Jade site. As soon as I did so, the search broke because the browser wouldn't go from a secure site to a non-secure site.

I started down the road of fixing it, but of course Solr and Nutch had moved up a number of versions, so they needed changes. Also, I've never been a Java person, so the whole stack on the search server was something that I was barely able to run at the best of times. Finally, since Solr and Nutch are Apache projects, they have huge amounts of documentation. Unfortunately, my brain can't read hundreds of pages and keep the relevant material in my head, just to decide what I need to do in order to make the software work for me.

To make a long story short, I've temporarily abandoned search on the Jade Systems site. I hope to get back to the problem in the near future.

Aside: For non-static web sites that use [Postgres](https://www.postgresql.org/), its built-in full-text search does a pretty good job of search.
