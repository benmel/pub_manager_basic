class MoveDescriptionTemplate < ActiveRecord::Migration
  def up
  	Description.all.each do |description|
  		FilledLiquidTemplate.create(filled_liquid_templatable_id: description.id, filled_liquid_templatable_type: "Description", content: description.template)
  	end
  end

  def down
  	FilledLiquidTemplate.destroy_all(filled_liquid_templatable_type: "Description")
  end
end
