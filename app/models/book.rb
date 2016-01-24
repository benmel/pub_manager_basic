class Book < ActiveRecord::Base
  belongs_to :project, inverse_of: :book
  has_one :front_section, inverse_of: :book, dependent: :destroy
  has_one :toc_section, inverse_of: :book, dependent: :destroy
  has_many :sections, inverse_of: :book, dependent: :destroy
  
  accepts_nested_attributes_for :front_section
  accepts_nested_attributes_for :toc_section
  accepts_nested_attributes_for :sections, reject_if: :all_blank
end
