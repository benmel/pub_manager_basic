class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.references :template, index: true, foreign_key: true
      t.text :name

      t.timestamps null: false
    end
  end
end
