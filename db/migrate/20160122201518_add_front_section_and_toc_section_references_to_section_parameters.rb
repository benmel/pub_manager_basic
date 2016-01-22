class AddFrontSectionAndTocSectionReferencesToSectionParameters < ActiveRecord::Migration
  def change
    add_reference :section_parameters, :front_section, index: true, foreign_key: true
    add_reference :section_parameters, :toc_section, index: true, foreign_key: true
  end
end
