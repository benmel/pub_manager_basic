# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  initializeTinyMce()
  initializeCocoon()
  initalizeSortable()

$(document).on 'page:before-unload', -> 
  unloadTinyMce()

$(document).on 'change', '#choose_front_section_liquid_template', (evt) ->
  FilledLiquidTemplates.fillWithLiquidTemplate $('#front-section-filled-liquid-template'), $(this).data('url'), $(this).val()

$(document).on 'change', '#choose_toc_section_liquid_template', (evt) ->
  FilledLiquidTemplates.fillWithLiquidTemplate $('#toc-section-filled-liquid-template'), $(this).data('url'), $(this).val()

$(document).on 'change', '.choose_body_section_liquid_template', (evt) ->
  FilledLiquidTemplates.fillWithLiquidTemplate $(this).siblings('.body-section-filled-liquid-template'), $(this).data('url'), $(this).val()

initializeTinyMce = ->
  tinymce.init
    selector: '.tinymce'
    plugins: 'paste code charmap visualblocks visualchars'
    toolbar: 'undo redo | styleselect  | bold italic | bullist numlist | code charmap | visualblocks visualchars'
    height: 300

unloadTinyMce = ->
  tinymce.remove()    

initializeCocoon = ->
  $('#body-sections').on 'cocoon:after-insert', (evt, bodySection) ->
    initializeTinyMce()

initalizeSortable = ->
  $('#sortable').sortable
    axis: 'y'
    update: (evt, ui) ->
      updateBodySectionRow ui.item.data('url'), ui.item.index()

updateBodySectionRow = (bodySectionUrl, rowOrderPosition) ->
  if bodySectionUrl and typeof rowOrderPosition is 'number'
    $.ajax
      url: bodySectionUrl
      method: 'PATCH'
      dataType: 'json'
      data:
        body_section:
          row_order_position: rowOrderPosition
