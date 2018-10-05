---
layout: post
title: Configuring Applications
date: '2016-08-28T21:33:00.001-07:00'
author: Larry Reid
tags:
modified_time: '2016-08-28T21:33:17.645-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5671754197301034022
blogger_orig_url: http://technopragmatica.blogspot.com/2016/08/configuring-applications.html
---

I once had experience with a browser-based application that would show pages that were links to another application. Since the URL of the other application would change depending on the environment (development, test, staging, production, etc.), the developers decided to put the URL in a field in a row in a configuration table in the database.

So far, so good. Per-environment configuration needs to be changeable. But it turned out that putting configuration in the database had some challenges. Configuration in the database is less convenient to put under revision control and to deploy with automated tools. So we didn't have the configuration as part of an automated build tool, and it was a bureaucratic nightmare each time we had to change the URL. (Simple files are easier to integrate with revision control and automated deployment tools.)

But what really caused problems was that the database contained more than just the protocol, host, domain, and port -- the stuff that would change for each environment. It included a template for query parameters as well. So the line in the configuration table looked something like this:
```
https://otherapplication.example.com:20400/search-page?parm1=%1,parm2=%2
```
The application would take the query string (`?parm1=%1,parm2=%2`), and fill in the placeholders (`%1`, `%2`) with values. The problem was, every time the requirements expanded and we needed more parameters, the configuration string had to change *for every environment.*

The parameters weren't part of the environment set-up, so they never should have been put in the configuration table. When you're parametrizing an application configuration, make sure you put *only* things that change per environment into the environment configuration parameters.

Unrelated to the above point, but important to note, is that we also found it very inconvenient that the placeholder marker in the URL was a percent sign. Percent signs are [URL-encodeable](https://en.wikipedia.org/wiki/Percent-encoding). When we had to e-mail each other with updates to the URL, we were constantly tripped up by our e-mail and spreadsheet programs "helpfully" URL-encoding the query parameters for us, turning `%1` into `%251`, for example.
