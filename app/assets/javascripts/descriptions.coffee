# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/       

replaceForm = (data) ->
  $('#new_description').replaceWith(data)

$(document).on 'change', '#choose_liquid_template', (evt) ->
  liquid_template_id = $(this).val()
  if liquid_template_id
    $.ajax 
      url: $(this).data('url')
      data:
        liquid_template_id: liquid_template_id
      type: 'GET'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        replaceForm(data)    
