# I want to setup up a keyup event on the value of the form, then execute the
# query below each time the key comes up, with the value of the input form (thi)
# in the query.

###
Set up the autocomplete on the search field.
I tried using Solr's Suggester, but it just wouldn't work.
There's another thing called Terms which works.
It has a quirk about the return value is an array with pairs of term, weight
###
jQuery ->
  ns = namespace("ca.jadesystems.search")
  ns.itemsOnPage = 3

  ns.searchEngine or= "https://search.jadesystems.ca:8983"
  ns.solrCore or= "cark"

  $( '#search' ).autocomplete
    source: ( request, response ) ->
      $.ajax
        url: ns.searchEngine + "/solr/" + ns.solrCore + "/terms"
        header: { Origin: "http://www.jadesystems.ca" }
        dataType: "jsonp"
        data:
          "terms.prefix": request.term
          "terms.fl": '_text_'
          rows: 10
          wt: 'json'
        jsonp: 'json.wrf'
        success: ( data ) ->
          # alert( "Good: " + data.terms.text.toString() )
          response( $.grep( data.terms._text_, ( o, i ) ->
            (i % 2) == 0 ))
        error: ( xhr, textStatus, errorThrown ) ->
          alert( "Bad: " + errorThrown )
    delay: 500
    minLength: 2

  ###
  When you get search results, put them into the page.
  ###
  populateSearchResults = ( data ) ->
    $('#search-results ul li.transient').remove()

    search_result = data
      .response
      .docs
      .filter((x) -> x.url? and x.title? )
    # alert( "Good: " + search_result.map((x) -> x.title ).toString() )

    results_list = $('#search-results-list')
    $.each(search_result, (i, o) ->
      (p = document.createElement('li')).className = 'transient'
      a = $(document.createElement('a'))
      a.prop('href', o.url)
      a.text(o.title)
      $(p).append(a)
      results_list.append(p))

  getSearchResults = ( page, firstSearchActions ) ->
    # alert first_page + " " + last_page
    # fakeSearchResults( page, firstSearchActions )
    return if ! $('#search').val()

    first_item = (page - 1) * ns.itemsOnPage
    # alert ns.searchEngine + "/solr/" + ns.solrCore + "/select"
    $.ajax
      url: ns.searchEngine + "/solr/" + ns.solrCore + "/select"
      header: { Origin: "http://www.jadesystems.ca" }
      dataType: "jsonp"
      data:
        "q": $("#search").val()
        start: first_item
        rows: ns.itemsOnPage
        wt: 'json'
      jsonp: 'json.wrf'
      success: ( data ) ->
        populateSearchResults( data )
        firstSearchActions( data ) if firstSearchActions?
      error: ( xhr, textStatus, errorThrown ) ->
        alert( "Bad: " + errorThrown )

  ###
  Use the pagination plugin
  http://flaviusmatis.github.io/simplePagination.js/
  ###
  firstSearchActions = ( data ) ->
    $('#pagination').pagination(
      items: data.response.numFound
      itemsOnPage: ns.itemsOnPage
      cssStyle: 'light-theme'
      onPageClick: ( pageNumber, event ) ->
        # alert pageNumber
        getSearchResults( pageNumber, null ))

    $('#search-results').show()

  ###
  Click on the button
  ###
  $('#search-button').click( -> getSearchResults( 1, firstSearchActions ))

  # TODO: Disable search button when there's nothing in the search box

  ###
  Hide the search results area.
  ###
  $('#clear-results').click(-> $('#search-results').hide())

  ###
  For testing.
  ###
  fakeSearchResults = ( page, firstSearchActions ) ->
    whole_list = {
      "responseHeader":{
        "status":0,
        "QTime":1,
        "params":{
          "indent":"true",
          "q":"content:larry",
          "_":"1424742241031",
          "wt":"json",
          "rows":"10"}},
      "response":{"numFound":7,"start":0,"docs":[
          {
            "id":"http://jadesystems.ca/",
            "title":"Fake Jade Systems Inc Home",
            "segment":"20150223170716",
            "boost":1.0,
            "digest":"6aaeaf371b0e599fa7db72eead1b34f2",
            "tstamp":"2015-02-24T01:07:24.381Z",
            "url":"http://jadesystems.ca/",
            "_version_":1493948247636443136},
          {
            "id":"http://jadesystems.ca/contact/",
            "title":"Fake Jade Systems Inc Contact Us",
            "segment":"20150223170808",
            "boost":0.5464532,
            "digest":"5e3d668c642224476293d075d1c95472",
            "tstamp":"2015-02-24T01:09:03.608Z",
            "url":"http://jadesystems.ca/contact/",
            "_version_":1493948582644940800},
          {
            "id":"http://jadesystems.ca/people/larry_reid/",
            "title":"Fake Jade Systems Inc Larry Reid",
            "segment":"20150223170808",
            "boost":0.5464532,
            "digest":"937e77467f9de00b06fbc1e7c9adabcf",
            "tstamp":"2015-02-24T01:08:53.155Z",
            "url":"http://jadesystems.ca/people/larry_reid/",
            "_version_":1493948582661718016},
          {
            "id":"http://jadesystems.ca/services/project_management/",
            "title":"Fake Jade Systems Inc Project Management",
            "segment":"20150223170808",
            "boost":0.5464532,
            "digest":"ccf6741ac91c90be6264a79b3cf8b64f",
            "tstamp":"2015-02-24T01:08:26.471Z",
            "url":"http://jadesystems.ca/services/project_management/",
            "_version_":1493948582796984320},
          {
            "id":"http://jadesystems.ca/services/",
            "title":"Fake Jade Systems Inc Services",
            "segment":"20150223170808",
            "boost":0.5464532,
            "digest":"6e0067d606621a634791e4b691b72f58",
            "tstamp":"2015-02-24T01:09:14.126Z",
            "url":"http://jadesystems.ca/services/",
            "_version_":1493948582707855360},
          {
            "id":"http://jadesystems.ca/services/it_consulting/",
            "title":"Fake Jade Systems Inc IT Consulting",
            "segment":"20150223170808",
            "boost":0.5464532,
            "digest":"c0780a86da30181feda30f06ae07db0a",
            "tstamp":"2015-02-24T01:08:37.521Z",
            "url":"http://jadesystems.ca/services/it_consulting/",
            "_version_":1493948582777061376},
          {
            "id":"http://jadesystems.ca/services/infrastructure_analysis/",
            "title":"Fake Jade Systems Inc Infrastructure Analysis",
            "segment":"20150223170808",
            "boost":0.5527708,
            "digest":"997e74b7a4845fb91d0c0d944d428e1e",
            "tstamp":"2015-02-24T01:08:16.131Z",
            "url":"http://jadesystems.ca/services/infrastructure_analysis/",
            "_version_":1493948582722535424}]
      }}

    return_list = $.extend(true, {}, whole_list)
    first_item = (page - 1) * ns.itemsOnPage
    return_list.response.docs = whole_list.response.docs.slice( first_item, first_item + ns.itemsOnPage )
    return_list.responseHeader.rows = return_list.response.docs.length
    populateSearchResults( return_list )
    firstSearchActions( return_list ) if firstSearchActions?
