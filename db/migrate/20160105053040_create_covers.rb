class CreateCovers < ActiveRecord::Migration
  def change
    create_table :covers do |t|
      t.text :photographer
      t.text :license
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
