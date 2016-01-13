# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'change', '#choose_template', (evt) ->
  	templateId = $('#choose_template option:selected').val()
  	if templateId
	    $.ajax '/templates/' + templateId,
	      type: 'GET'
	      dataType: 'json'
	      error: (jqXHR, textStatus, errorThrown) ->
	        console.log(textStatus)
	      success: (data, textStatus, jqXHR) ->
	        fillForm(data)
  
  $(document).on 'click', 'button.add-description-parameter-button', ->
 		addParameter($(this))
 	
 	$(document).on 'click', 'button.remove-description-parameter-button', ->
  	removeParameter($(this))
  
  fillForm = (data) ->
  	$('#description_template').val(data.content)
  	$('form .filled-parameters').remove()
  	fillParameter(p.name) for p in data.parameters

  fillParameter = (name) ->
  	button = $('form .add-description-parameter-button')
 		addParameter(button)
 		button.prev('form .filled-parameters').children('input[id$="_name"]').val(name)

 	addParameter = (node) ->
 		newId = new Date().getTime();
 		regexp = new RegExp('new_filled_parameters', 'g')
 		node.before($('div.hidden-fields')[0].innerHTML.replace(regexp, newId))

 	removeParameter = (node) ->
 		node.prev('form input[type=hidden]').val('1');
  	node.closest('form .filled-parameters').hide();		
