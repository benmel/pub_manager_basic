class CreateSectionParameters < ActiveRecord::Migration
  def change
    create_table :section_parameters do |t|
      t.references :section, index: true, foreign_key: true
      t.text :name
      t.text :value

      t.timestamps null: false
    end
  end
end
