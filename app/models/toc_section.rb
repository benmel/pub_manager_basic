class TocSection < ActiveRecord::Base
  belongs_to :book, inverse_of: :toc_section
  has_many :section_parameters, inverse_of: :toc_section, dependent: :destroy
  accepts_nested_attributes_for :section_parameters, reject_if: :all_blank, allow_destroy: true
  validates :content, presence: true
end
