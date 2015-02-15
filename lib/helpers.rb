include Nanoc::Helpers::LinkTo

require 'json'
require 'uri'

module OSS
  class Search
    def initialize(query_string)
      @query_string = query_string
      @index = "collection1"
      @server = "solr01"
      @port = ":8983"
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
      return {
        q: @query_string,
        start: 0,
        rows: 10,
        lang: "ENGLISH",
        fl: [
          "url"
        ],
        wt: "json",
        indent: "true"
      }
    end
    def parameter_string
      # JSON.pretty_generate( parameters_for_post)
      '?' + URI.encode_www_form(parameters_for_post)
    end
    def curl_string
      'curl "' + search_url + '"'
    end
    def curl
      `#{curl_string}`
    end
    def autocomplete_url(string = "")
      "#{@url}/services/rest/index/#{@index}/autocompletion/autocomplete?prefix=#{string}&rows=10"
    end
    def search_url(string = "")
      @url + '/solr/' + @index + '/select' + parameter_string
    end
  end
end
