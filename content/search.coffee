# I want to setup up a keyup event on the value of the form, then execute the
# query below each time the key comes up, with the value of the input form (thi)
# in the query.

###
Set up the autocomplete on the search field.
I tried using Solr's Suggester, but it just wouldn't work.
There's another thing call Terms which works.
It has a quirk about the return value is an array with pairs of term, weight
###
jQuery ->
  $( '#search' ).autocomplete
    source: ( request, response ) ->
      $.ajax
        url: "http://solr01:8983/solr/terms"
        header: { Origin: "http://www.jadesystems.ca" }
        dataType: "jsonp"
        data:
          "terms.prefix": request.term
          "terms.fl": 'content'
          rows: 10
          wt: 'json'
        jsonp: 'json.wrf'
        success: ( data ) ->
          # alert( "Good: " + data.terms.text.toString() )
          response( $.grep( data.terms.content, ( o, i ) ->
            (i % 2) == 0 ))
        error: ( xhr, textStatus, errorThrown ) ->
          alert( "Bad: " + errorThrown )
    delay: 500
    minLength: 2

  ###
  Click on the search button gets search results from the search server,
  puts them into the search document, and shows the element.
  ###
  $('#search-button').click(->
    $.ajax
      url: "http://solr01:8983/solr/select"
      header: { Origin: "http://www.jadesystems.ca" }
      dataType: "jsonp"
      data:
        "q": 'content:' + $("#search").val()
        rows: 10
        wt: 'json'
      jsonp: 'json.wrf'
      success: ( data ) ->
        search_result = data.response.docs.filter((x) -> x.url? and x.title? )
        # alert( "Good: " + search_result.map((x) -> x.title ).toString() )

        results_list = $('#search-results ul')

        $('#search-results ul li.transient').remove()

        $.each(search_result, (i, o) ->
          (p = document.createElement('li')).className = 'transient'
          a = $(document.createElement('a'))
          a.prop('href', o.url)
          a.text(o.title)
          $(p).append(a)
          # p.innerHTML = o.title
          results_list.append(p))
        $('#search-results').show()
      error: ( xhr, textStatus, errorThrown ) ->
        alert( "Bad: " + errorThrown ))

  ###
  Hide the search results area.
  ###
  $('#clear-results').click(-> $('#search-results').hide())
