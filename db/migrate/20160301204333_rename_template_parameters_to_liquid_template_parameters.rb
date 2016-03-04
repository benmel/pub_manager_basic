class RenameTemplateParametersToLiquidTemplateParameters < ActiveRecord::Migration
  def change
  	rename_table :template_parameters, :liquid_template_parameters
  end
end
