class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :book, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
