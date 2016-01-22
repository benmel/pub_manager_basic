class RemoveContentFromBooks < ActiveRecord::Migration
  def change
  	remove_column :books, :content, :text
  end
end
