class AddNameToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :name, :text
  end
end
