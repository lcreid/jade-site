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
        # puts "Writing to #{output_file}"
        # puts "Header:\n#{match[1]}"
        # puts "HTML:\n#{match[2]}"
        fd.write(match[1])
        doc = Kramdown::Document.new(match[2], :html_to_native => true).to_kramdown
        fd.write(doc)
      end
    end
    nil
  end
end
