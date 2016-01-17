class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :project, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
