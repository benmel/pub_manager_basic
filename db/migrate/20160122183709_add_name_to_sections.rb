class AddNameToSections < ActiveRecord::Migration
  def change
    add_column :sections, :name, :text
  end
end
