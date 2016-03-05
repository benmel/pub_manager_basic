class FrontSection < ActiveRecord::Base
  belongs_to :book, inverse_of: :front_section
  has_one :filled_liquid_template, as: :filled_liquid_templatable, dependent: :destroy
  accepts_nested_attributes_for :filled_liquid_template
end
