---
layout: post
title: Solr and Rails
date: '2009-03-22T15:13:00.000-07:00'
author: Larry Reid
tags:
- Collaboration
- Ruby on Rails
- Search
modified_time: '2009-03-22T21:22:26.885-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4934283771730241303
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/solr-and-rails.html
---

Well, after some long diversions I have Solr working in some simple test
cases with Rails. The long diversion was partly caused by not
understanding what was offered by the Rails Solr plug-in, so I'm going
to give an overview here, and a link to detailed instructions for Solr
in Rails at the end of this post.  
  
The Rails plug-in for Solr from git:<span style="color: rgb(0, 0, 0);
font-weight: bold;">//</span>github.com<span style="color: rgb(0, 0, 0);
font-weight: bold;">/</span>mattmatt<span style="color: rgb(0, 0, 0);
font-weight: bold;">/</span>acts\_as\_solr.git includes a complete
installation of Solr. You don't need to install Solr separately. (My
"long diversion" is that I rushed off and installed Solr separately, and
spent a fair bit of time getting it running due to my ignorance of how
it worked.)  
  
If you want to index Word, Excel, PDF, and other types of documents,
there is a bit of additional configuration to do. To index those files
types you have to get a nightly build of Solr from [here][1], and copy
some files and directories as described in the link at the end of this
post. You have to add the following lines to
example/solr/conf/solrconf.xml:  
<pre> &lt;requestHandler name="/update/extract"
class="org.apache.solr.handler.extraction.ExtractingRequestHandler"&gt; 

 &lt;lst name="defaults"&gt;  
 &lt;str name="ext.map.Last-Modified"&gt;last\_modified&lt;/str&gt;  
 &lt;bool name="ext.ignore.und.fl"&gt;true&lt;/bool&gt;  
 &lt;/lst&gt;  
 &lt;/requestHandler&gt;</pre>The plug-in also includes rake tasks to
start and stop instances of the Solr server for development, test and
production -- very handy. Just type <pre>rake solr:start RAILS\_ENV=test
</pre>to start the test Solr server (default environment is
development). It also gives you a yaml file in your environment
directory to configure the ports that each instance of Solr will use (as
installed: production on 8983, test on 8981 and development on 8982).  
  
One thing I learned on my diversion is that Solr comes with an
administration user interface that shows how many documents are in the
Solr database, and lets you try ad-hoc queries. It's a good way to test
if Solr is actually running. For example, after running the rake task to
start Solr for development, you can browse to localhost:8982/solr/admin
and you should get the Solr administration page.  
  
So that's the overview. The detailed write up is [here][2]. It's good. I
just wish I had this overview first so I knew what I was getting and
where I was going.



[1]: http://people.apache.org/builds/lucene/solr/nightly/
[2]: http://www.lucidimagination.com/blog/2009/02/17/acts_as_solr_cell/
