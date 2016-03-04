class MoveSectionParameters < ActiveRecord::Migration
  def up
  	SectionParameter.all.each do |section_parameter|
  		if section_parameter.front_section_id and FrontSection.find(section_parameter.front_section_id).filled_liquid_template
  			FilledLiquidTemplateParameter.create(
  				filled_liquid_template_id: FrontSection.find(section_parameter.front_section_id).filled_liquid_template.id, 
  				name: section_parameter.name, 
  				value: section_parameter.value)
  		elsif section_parameter.toc_section_id and TocSection.find(section_parameter.toc_section_id).filled_liquid_template
  			FilledLiquidTemplateParameter.create(
  				filled_liquid_template_id: TocSection.find(section_parameter.toc_section_id).filled_liquid_template.id, 
  				name: section_parameter.name, 
  				value: section_parameter.value)
  		elsif section_parameter.body_section_id and BodySection.find(section_parameter.body_section_id).filled_liquid_template
  			FilledLiquidTemplateParameter.create(
  				filled_liquid_template_id: BodySection.find(section_parameter.body_section_id).filled_liquid_template.id, 
  				name: section_parameter.name, 
  				value: section_parameter.value)
  		end	
  	end
  end

  def down
  	FilledLiquidTemplateParameter.joins(:filled_liquid_template).where("filled_liquid_templates.filled_liquid_templatable_type = 'FrontSection'").destroy_all
  	FilledLiquidTemplateParameter.joins(:filled_liquid_template).where("filled_liquid_templates.filled_liquid_templatable_type = 'TocSection'").destroy_all
  	FilledLiquidTemplateParameter.joins(:filled_liquid_template).where("filled_liquid_templates.filled_liquid_templatable_type = 'BodySection'").destroy_all
  end
end
