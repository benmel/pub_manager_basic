class CreateFilledParameters < ActiveRecord::Migration
  def change
    create_table :filled_parameters do |t|
      t.references :description, index: true, foreign_key: true
      t.text :name
      t.text :value

      t.timestamps null: false
    end
  end
end
