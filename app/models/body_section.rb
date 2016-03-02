class BodySection < ActiveRecord::Base
  belongs_to :book, inverse_of: :body_sections
  has_many :section_parameters, inverse_of: :body_section, dependent: :destroy
  accepts_nested_attributes_for :section_parameters, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true
  validates :content, presence: true
  validates_with LiquidValidator

  include RankedModel
  ranks :row_order, with_same: :book_id
end
