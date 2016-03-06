class MoveLiquidTemplateTemplateType < ActiveRecord::Migration
  def up
  	LiquidTemplate.all.each do |liquid_template|
  		case liquid_template.template_type
      when 'other'
      	liquid_template.category = :other
      when 'description'
      	liquid_template.category = :description
      when 'front_section'
      	liquid_template.category = :front_section
      when 'toc_section'
      	liquid_template.category = :toc_section
      when 'body_section'
      	liquid_template.category = :body_section
      else
      	liquid_template.category = :other
      end
      liquid_template.save
  	end
  end

  def down
  	LiquidTemplate.update_all(category: :other)
  end
end
