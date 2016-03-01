class FrontSection < ActiveRecord::Base
  belongs_to :book, inverse_of: :front_section
  has_many :section_parameters, inverse_of: :front_section, dependent: :destroy
  accepts_nested_attributes_for :section_parameters, reject_if: :all_blank, allow_destroy: true
  validates :content, presence: true
  validates_with LiquidValidator
end
