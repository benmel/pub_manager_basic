class RenameSectionsToBodySections < ActiveRecord::Migration
  def change
  	rename_table :sections, :body_sections
  end
end
