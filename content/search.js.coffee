# I want to setup up a keyup event on the value of the form, then execute the
# query below each time the key comes up, with the value of the input form (thi)
# in the query.

jQuery ->
  $( '#search' ).autocomplete
    source: ( request, response ) ->
      $.ajax
        url: "http://opensearchserver01:9090/services/rest/index/Jade/autocompletion/autocomplete"
        dataType: "jsonp"
        data:
          prefix: request.term
          rows: 10
        success: ( data ) ->
          alert( "Good: " + data.terms )
          response( data.terms )
        error: ( xhr, textStatus, errorThrown ) ->
          alert( "Bad: " + errorThrown )
    delay: 500
    minLength: 2
