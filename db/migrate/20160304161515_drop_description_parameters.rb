class DropDescriptionParameters < ActiveRecord::Migration
  def change
  	drop_table :description_parameters
  end
end
