---
layout: post
title: Tika and Solr
date: '2009-03-26T07:33:00.001-07:00'
author: Larry Reid
tags:
- Collaboration
- Search
modified_time: '2009-03-26T07:51:12.723-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-9172837766334001789
blogger_orig_url: http://technopragmatica.blogspot.com/2009/03/tika-and-solr.html
---

This is just a quick note to document another experience with Solr.  
  
Background: To index Word, Excel, PDF and other "unstructured"
documents, Solr uses Tika, another Apache project. Tika comes bundled in
Solr and is ready to run in Solr. However, if you want to run Tika
individually (e.g. you don't trust your installation, or you're just
curious) you have to copy a few .jar files around (Java experts who can
manage class paths will probably tell me there's a better way to do
this).  
  
I did <pre>cd \[Your path\]/apache-solr-nightly/lib  
cp commons-io-1.4.jar commons-codec-1.3.jar \[Your
path\]/apache-solr-nightly/example/solr/lib  
cp ~/.m2/repository/org/jempbox/jempbox/0.2.0/jempbox-0.2.0.jar \[Your
path\]/apache-solr-nightly/example/solr/lib</pre>(I have no idea where
~/.m2 came from. It may have been when I ran the Tika build.) Then I
could run <pre>java -jar tika-0.2.jar</pre> in that directory.

