class FilledLiquidTemplateParameter < ActiveRecord::Base
  belongs_to :filled_liquid_template, inverse_of: :filled_liquid_template_parameters
  validates :name, presence: true
end
