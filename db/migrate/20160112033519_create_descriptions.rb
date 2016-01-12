class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.references :project, index: true, foreign_key: true
      t.text :template
      t.text :content
      t.text :chapter_list
      t.text :excerpt

      t.timestamps null: false
    end
  end
end
