class Section < ActiveRecord::Base
  belongs_to :book, inverse_of: :sections
  has_many :section_parameters, inverse_of: :section, dependent: :destroy
  accepts_nested_attributes_for :section_parameters, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true
  validates :content, presence: true

  include RankedModel
  ranks :row_order
end
