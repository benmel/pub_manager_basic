class CreateTocSections < ActiveRecord::Migration
  def change
    create_table :toc_sections do |t|
      t.references :book, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
