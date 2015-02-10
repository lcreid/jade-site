include Nanoc::Helpers::LinkTo

require 'json'

module OSS
  class Search
    def initialize(query_string)
      @query_string = query_string
      @index = "Jade"
      @server = "opensearchserver01"
      @port = ":9090"
      @url = "http://#{@server+@port}"
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
    def autocomplete_url(string = "")
      "#{@url}/services/rest/index/#{@index}/autocompletion/autocomplete?prefix=#{string}&rows=10"
    end
  end
end
