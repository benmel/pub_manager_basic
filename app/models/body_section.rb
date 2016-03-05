class BodySection < ActiveRecord::Base
	belongs_to :book, inverse_of: :body_sections
	has_one :filled_liquid_template, as: :filled_liquid_templatable, dependent: :destroy
	accepts_nested_attributes_for :filled_liquid_template
	validates :name, presence: true

	include RankedModel
	ranks :row_order, with_same: :book_id
end
