$(document).on 'click', 'a.loadmore', ->

  maxid = $(".events p:last").data('id')
  $.getJSON '/', {maxid: maxid}, (data) ->
    $.each data, (index, event) ->
      $(".events").append("<p data-id='#{event.id}'>#{event.name}</p>")
