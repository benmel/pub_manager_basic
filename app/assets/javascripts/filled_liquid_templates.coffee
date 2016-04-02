class FilledLiquidTemplates
  @fillWithLiquidTemplate: ($filledLiquidTemplate, liquidTemplatesUrl, liquidTemplateId) ->
    if $filledLiquidTemplate and liquidTemplatesUrl and liquidTemplateId
      $.ajax
        url: "#{liquidTemplatesUrl}/#{liquidTemplateId}"
        dataType: 'json'
        error: (jqXHR, textStatus, errorThrown) =>
          console.log(textStatus)
        success: (data, textStatus, jqXHR) =>
          @replaceFields($filledLiquidTemplate, data)    

  @replaceFields: ($filledLiquidTemplate, data) ->
    @clearFields($filledLiquidTemplate)
    @content($filledLiquidTemplate).val(data.content)
    @addParameterField $filledLiquidTemplate, parameter for parameter in data.liquid_template_parameters

  @clearFields: ($filledLiquidTemplate) ->
    @content($filledLiquidTemplate).val('')
    @parametersNestedFields($filledLiquidTemplate).remove()

  @addParameterField: ($filledLiquidTemplate, parameter) ->
    @parametersAddButton($filledLiquidTemplate).click()
    @parametersLastName($filledLiquidTemplate).val(parameter.name)

  @content: ($filledLiquidTemplate) ->
    $filledLiquidTemplate.children('.filled-liquid-template-content').children('textarea')

  @parameters: ($filledLiquidTemplate) ->
    $filledLiquidTemplate.children('.filled-liquid-template-parameters')

  @parametersNestedFields: ($filledLiquidTemplate) ->
    @parameters($filledLiquidTemplate).find('.nested-fields')

  @parametersAddButton: ($filledLiquidTemplate) ->
    @parameters($filledLiquidTemplate).find('.links').children('.add-filled-liquid-template-parameter')

  @parametersLastName: ($filledLiquidTemplate) ->
    @parametersNestedFields($filledLiquidTemplate).last().children('.filled-liquid-template-parameter-name').children('input')

(exports ? this).FilledLiquidTemplates = FilledLiquidTemplates