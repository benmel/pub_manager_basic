class FilledLiquidTemplate < ActiveRecord::Base
  belongs_to :filled_liquid_templatable, polymorphic: true
  has_many :filled_liquid_template_parameters, inverse_of: :filled_liquid_template, dependent: :destroy
end
