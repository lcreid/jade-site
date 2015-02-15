# I want to setup up a keyup event on the value of the form, then execute the
# query below each time the key comes up, with the value of the input form (thi)
# in the query.

jQuery ->
  $( '#search' ).autocomplete
    source: ( request, response ) ->
      $.ajax
        url: "http://solr01:8983/solr/select"
        header: { Origin: "http://www.jadesystems.ca" }
        dataType: "jsonp"
        data:
          q: request.term
          rows: 10
          wt: 'json'
        jsonp: 'json.wrf'
        success: ( data ) ->
          alert( "Good: " + data.response.docs.map((x) -> x.title[0] ).toString() )
          response( data.response.docs.map((x) -> x.title[0] ) )
        error: ( xhr, textStatus, errorThrown ) ->
          alert( "Bad: " + errorThrown )
    delay: 500
    minLength: 2
