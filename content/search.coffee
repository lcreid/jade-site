# I want to setup up a keyup event on the value of the form, then execute the
# query below each time the key comes up, with the value of the input form (thi)
# in the query.

jQuery ->
  $( '#search' ).autocomplete
    source: ( request, response ) ->
      $.ajax
        url: "http://solr01:8983/solr/terms"
        header: { Origin: "http://www.jadesystems.ca" }
        dataType: "jsonp"
        data:
          "terms.prefix": request.term
          "terms.fl": 'text'
          rows: 10
          wt: 'json'
        jsonp: 'json.wrf'
        success: ( data ) ->
          # alert( "Good: " + data.terms.text.toString() )
          response( data.terms.text )
        error: ( xhr, textStatus, errorThrown ) ->
          alert( "Bad: " + errorThrown )
    delay: 500
    minLength: 2

  $('#search-button').click(->
    test_data = {
      "responseHeader":{
        "status":0,
        "QTime":0,
        "params":{
          "indent":"true",
          "start":"0",
          "q":"solr",
          "wt":"json",
          "lang":"ENGLISH",
          "rows":"10"}},
      "response":{"numFound":3,"start":0,"docs":[
        {
          "links":["rect",
            "Links of first",
            "rect",
            "ClientUtils.html"],
          "url":"url of first",
          "id":"ID of first",
          "title":["Title of first"],
          "content_type":["text/html"],
          "resourcename":"Resourcename of first",
          "content":["Content of first"],
          "_version_":1492696537061392384},
        {
          "links":["rect",
            "Links of second",
            "rect",
            "ClientUtils.html"],
          "url":"url of second",
          "id":"ID of second",
          "title":["Title of second"],
          "content_type":["text/html"],
          "resourcename":"Resourcename of second",
          "content":["Content of second"],
          "_version_":1492696537061392384},
        {
          "links":["rect",
            "Links of third",
            "rect",
            "ClientUtils.html"],
          "url":"url of third",
          "id":"ID of third",
          "title":["Title of third"],
          "content_type":["text/html"],
          "resourcename":"Resourcename of third",
          "content":["Content of third"],
          "_version_":1492696537061392384}]}}

    search_result = test_data.response.docs.filter((x) -> `'title' in x` )

    $.ajax
      url: "http://solr01:8983/solr/select"
      header: { Origin: "http://www.jadesystems.ca" }
      dataType: "jsonp"
      data:
        "q": $("#search").val()
        "fl": "text"
        "fl": "url"
        "fl": "title"
        rows: 10
        wt: 'json'
      jsonp: 'json.wrf'
      success: ( data ) ->
        useful_results = data.response.docs.filter((x) -> `'title' in x` )
        alert( "Good: " + useful_results.map((x) -> x.title[0] ).toString() )
        search_result = useful_results

        results_list = $('#search-results ul')

        $('#search-results ul li.transient').remove()

        $.each(search_result, (i, o) ->
          (p = document.createElement('li')).className='transient'
          p.innerHTML = o.title[0]
          results_list.append(p))
        $('#search-results').show()
      error: ( xhr, textStatus, errorThrown ) ->
        alert( "Bad: " + errorThrown ))

  $('#clear-results').click(-> $('#search-results').hide())
