class MoveDescriptionParameters < ActiveRecord::Migration
  def up
  	DescriptionParameter.all.each do |description_parameter|
  		if description_parameter.description and description_parameter.description.filled_liquid_template
  			FilledLiquidTemplateParameter.create(
  				filled_liquid_template_id: description_parameter.description.filled_liquid_template.id, 
  				name: description_parameter.name, 
  				value: description_parameter.value)
  		end
  	end
  end

  def down
  	FilledLiquidTemplateParameter.joins(:filled_liquid_template).where("filled_liquid_templates.filled_liquid_templatable_type = 'Description'").destroy_all
  end
end
