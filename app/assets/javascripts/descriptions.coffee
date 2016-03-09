# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/       

$(document).on 'change', '#choose_liquid_template', (evt) ->
  FilledLiquidTemplates.fillWithLiquidTemplate $('#description-filled-liquid-template'), $(this).data('url'), $(this).val()
