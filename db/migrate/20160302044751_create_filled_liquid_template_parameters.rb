class CreateFilledLiquidTemplateParameters < ActiveRecord::Migration
  def change
    create_table :filled_liquid_template_parameters do |t|
      t.references :filled_liquid_template, index: { name: 'index_fl_template_parameters_on_fl_template_id' }, foreign_key: true
      t.text :name
      t.text :value

      t.timestamps null: false
    end
  end
end
