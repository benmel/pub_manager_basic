class RenameFilledParametersToDescriptionParameters < ActiveRecord::Migration
  def change
  	rename_table :filled_parameters, :description_parameters
  end
end
