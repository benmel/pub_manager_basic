class ChangeLiquidTemplateParametersTemplateName < ActiveRecord::Migration
  def change
  	rename_column :liquid_template_parameters, :template_id, :liquid_template_id
  end
end
