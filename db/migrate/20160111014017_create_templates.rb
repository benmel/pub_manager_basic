class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
