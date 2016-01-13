# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'click', 'button.add-template-parameter-button', ->
 		addParameter($(this))
 	
 	$(document).on 'click', 'button.remove-template-parameter-button', ->
  	removeParameter($(this))

  addParameter = (node) ->
 		newId = new Date().getTime();
 		regexp = new RegExp('new_parameters', 'g')
 		node.before($('div.hidden-fields')[0].innerHTML.replace(regexp, newId))

 	removeParameter = (node) ->
 		node.prev('form input[type=hidden]').val('1');
  	node.closest('form .parameters').hide();	
