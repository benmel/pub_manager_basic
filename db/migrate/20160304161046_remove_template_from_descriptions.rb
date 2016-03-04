class RemoveTemplateFromDescriptions < ActiveRecord::Migration
  def change
  	remove_column :descriptions, :template, :text
  end
end
