class Book < ActiveRecord::Base
  belongs_to :project, inverse_of: :book
  has_one :front_section, inverse_of: :book, dependent: :destroy
  has_one :toc_section, inverse_of: :book, dependent: :destroy
  has_many :sections, inverse_of: :book, dependent: :destroy
end
