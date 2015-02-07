include Nanoc::Helpers::LinkTo

require 'json'

module OSS
  class Search
    def initialize(query_string)
      @query_string = query_string
    end
    def html
      "<div>" + @query_string + "</div>"
    end
    def parameters_for_post
      # '     ' +
      # '{
      #   "query":"' + @query_string + '",
      #   "start":0,
      #   "rows":10,
      #   "lang":"ENGLISH",
      #   "returnedFields": [
      #     "url",
      #     "backlinkCount"
      #   ]
      # }'
      JSON.pretty_generate( {
        query: @query_string,
        start: 0,
        rows: 10,
        lang: "ENGLISH",
        returnedFields: [
          "url"
        ]
      })
    end
    def curl_string
      'curl -XPOST -H "Content-Type: application/json" -d \'' +
        parameters_for_post +
        '\' http://opensearchserver01:9090/services/rest/index/Jade/search/pattern'
    end
    def curl
      `#{curl_string}`
    end
  end
end
