class MoveSectionContent < ActiveRecord::Migration
  def up
  	FrontSection.all.each do |front_section|
  		unless front_section.filled_liquid_template
	  		FilledLiquidTemplate.create(
	  			filled_liquid_templatable_id: front_section.id, 
	  			filled_liquid_templatable_type: "FrontSection", 
	  			content: front_section.content)
	  		front_section.content = 'Temporary content'
	  		front_section.save
  		end
  	end

  	TocSection.all.each do |toc_section|
  		unless toc_section.filled_liquid_template
	  		FilledLiquidTemplate.create(
	  			filled_liquid_templatable_id: toc_section.id, 
	  			filled_liquid_templatable_type: "TocSection", 
	  			content: toc_section.content)
	  		toc_section.content = 'Temporary content'
	  		toc_section.save
  		end
  	end

  	BodySection.all.each do |body_section|
  		unless body_section.filled_liquid_template
	  		FilledLiquidTemplate.create(
	  			filled_liquid_templatable_id: body_section.id, 
	  			filled_liquid_templatable_type: "BodySection", 
	  			content: body_section.content)
	  		body_section.content = 'Temporary content'
	  		body_section.save
  		end
  	end
  end

  def down
  	FrontSection.all.each do |front_section|
  		filled_liquid_template = front_section.filled_liquid_template
  		front_section.content = filled_liquid_template.content
  		front_section.save
  		filled_liquid_template.destroy
  	end

  	TocSection.all.each do |toc_section|
  		filled_liquid_template = toc_section.filled_liquid_template
  		toc_section.content = filled_liquid_template.content
  		toc_section.save
  		filled_liquid_template.destroy
  	end

  	BodySection.all.each do |body_section|
  		filled_liquid_template = body_section.filled_liquid_template
  		body_section.content = filled_liquid_template.content
  		body_section.save
  		filled_liquid_template.destroy
  	end
  end
end
