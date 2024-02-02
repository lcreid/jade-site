---
layout: post
title: Converting HTML Jekyll Pages to Markdown
author: Larry Reid
tags:
---

I had never got around to converting the majority of my posts to Markdown after I moved my blog from Blogspot.

This is the script I used:

```ruby
# frozen_string: true

require "kramdown"
require "debug"

class HtmlToMarkdown
  def initialize(root)
    @root = root
  end

  def convert
    Dir.glob(@root).each do |input_file|
      match = /(^---$.*^---$\n*)(.*)/m.match(File.read(input_file))
      File.delete(input_file)
      output_file = File.join(
        File.dirname(input_file),
        File.basename(input_file, ".html") + ".md",
      )
      File.open(output_file, "w") do |fd|
        fd.write(match[1])
        doc = Kramdown::Document.new(match[2], :html_to_native => true).to_kramdown
        fd.write(doc)
      end
    end
    nil
  end
end
```

You should be sure to have your posts in some kind of revision control, because this script will delete the `.html` files while converting.

I ran the script by starting the console like this:

```bash
irb -Ilib
require_relative "lib/html_to_markdown"
HtmlToMarkdown.new("_posts/**/*.html").convert
```

It's not perfect, but it's a pretty good conversion.
