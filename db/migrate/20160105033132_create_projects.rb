class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :title
      t.text :subtitle
      t.text :author
      t.text :keywords
      t.text :description
      t.text :isbn10
      t.text :isbn13

      t.timestamps null: false
    end
  end
end
