class RemoveTemplateTypeFromLiquidTemplates < ActiveRecord::Migration
  def change
    remove_column :liquid_templates, :template_type, :integer
  end
end
