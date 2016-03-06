class AddCategoryToLiquidTemplates < ActiveRecord::Migration
  def change
    add_column :liquid_templates, :category, :string
  end
end
