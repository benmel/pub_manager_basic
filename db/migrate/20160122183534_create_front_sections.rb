class CreateFrontSections < ActiveRecord::Migration
  def change
    create_table :front_sections do |t|
      t.references :book, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
