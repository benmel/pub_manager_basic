class RenameTemplatesToLiquidTemplates < ActiveRecord::Migration
  def change
  	rename_table :templates, :liquid_templates
  end
end
