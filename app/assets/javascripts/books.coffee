# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#choose_front_section_template', (evt) ->
	prepareData $(this), $('#front-section')

$(document).on 'change', '#choose_toc_section_template', (evt) ->
	prepareData $(this), $('#toc-section')

$(document).on 'change', '.choose_section_template', (evt) -> 
	prepareData $(this), $(this).parent()     

prepareData = (node, section) ->
	url = node.data('url')
	template_id = node.val()
	section_type = node.data('section-type')
	getForm url, template_id, section_type, section

getForm = (url, template_id, section_type, section) ->
	if !!url and !!section_type and !!template_id and !!section
		$.ajax 
			url: url
			data:
				template_id: template_id
				section_type: section_type
			type: 'GET'
			dataType: 'html'
			error: (jqXHR, textStatus, errorThrown) ->
				console.log(textStatus)
			success: (data, textStatus, jqXHR) ->
				replaceForm(section, data)

replaceForm = (section, data)	->
	section.replaceWith(data)
