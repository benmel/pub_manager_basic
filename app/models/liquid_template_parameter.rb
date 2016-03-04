class LiquidTemplateParameter < ActiveRecord::Base
  belongs_to :liquid_template, inverse_of: :liquid_template_parameters
  validates :name, presence: true
end
