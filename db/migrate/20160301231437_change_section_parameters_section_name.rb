class ChangeSectionParametersSectionName < ActiveRecord::Migration
  def change
  	rename_column :section_parameters, :section_id, :body_section_id
  end
end
