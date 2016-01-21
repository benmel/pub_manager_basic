# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/       

replaceForm = (data) ->
  $('#new_description').replaceWith(data)

$(document).on 'change', '#choose_template', (evt) ->
  template_id = $(this).val()
  if template_id
    $.ajax 
      url: $(this).data('url')
      data:
        template_id: template_id
      type: 'GET'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        replaceForm(data)    
