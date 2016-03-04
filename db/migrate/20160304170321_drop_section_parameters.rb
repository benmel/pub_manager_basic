class DropSectionParameters < ActiveRecord::Migration
  def change
  	drop_table :section_parameters
  end
end
