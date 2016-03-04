class CreateFilledLiquidTemplates < ActiveRecord::Migration
  def change
    create_table :filled_liquid_templates do |t|
      t.references :filled_liquid_templatable, polymorphic: true, index: { name: 'index_fl_templates_on_fl_templatable_type_and_fl_templatable_id' }
      t.text :content

      t.timestamps null: false
    end
  end
end
