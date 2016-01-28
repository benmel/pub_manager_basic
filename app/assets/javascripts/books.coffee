# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
	initializeTinyMce()
	initializeCocoon()
	initalizeSortable()

$(document).on 'change', '#choose_front_section_template', (evt) ->
	prepareData $(this), $('#front-section')

$(document).on 'change', '#choose_toc_section_template', (evt) ->
	prepareData $(this), $('#toc-section')

$(document).on 'change', '.choose_section_template', (evt) -> 
	prepareData $(this), $(this).parent()     

initializeTinyMce = ->
	tinymce.remove()
	bindTinyMce()

initializeCocoon = ->
	$('#sections').on 'cocoon:after-insert', (evt, section) ->
		bindTinyMce()

initalizeSortable = ->
	$('#sortable').sortable
		axis: 'y'
		update: (evt, ui) ->
			updateSectionRow ui.item.data('url'), ui.item.index()

bindTinyMce = ->
	tinymce.init
		selector: '.tinymce'
		plugins: 'paste code charmap visualblocks visualchars'
		toolbar: 'undo redo | styleselect  | bold italic | bullist numlist | code charmap | visualblocks visualchars'
		height: 300

prepareData = (node, section) ->
	url = node.data('url')
	template_id = node.val()
	section_type = node.data('section-type')
	getForm url, template_id, section_type, section

getForm = (url, template_id, section_type, section) ->
	if !!url and !!template_id and !!section_type and !!section
		$.ajax 
			url: url
			method: 'GET'
			dataType: 'html'
			data:
				template_id: template_id
				section_type: section_type
			error: (jqXHR, textStatus, errorThrown) ->
				console.log(textStatus)
			success: (data, textStatus, jqXHR) ->
				replaceForm(section, data)

replaceForm = (section, data)	->
	section.replaceWith(data)
	bindTinyMce()

updateSectionRow = (url, row_order_position) ->
	if !!url and typeof row_order_position is 'number'
		$.ajax
			url: url
			method: 'PATCH'
			dataType: 'json'
			data:
				section:
					row_order_position: row_order_position
