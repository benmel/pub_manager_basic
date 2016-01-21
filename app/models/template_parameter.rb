class TemplateParameter < ActiveRecord::Base
  belongs_to :template, inverse_of: :template_parameters
  validates :name, presence: true
end
