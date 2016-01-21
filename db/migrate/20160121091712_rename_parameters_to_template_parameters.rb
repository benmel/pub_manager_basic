class RenameParametersToTemplateParameters < ActiveRecord::Migration
  def change
  	rename_table :parameters, :template_parameters
  end
end
