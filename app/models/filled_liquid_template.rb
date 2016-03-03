class FilledLiquidTemplate < ActiveRecord::Base
  belongs_to :filled_liquid_templatable, polymorphic: true
  has_many :filled_liquid_template_parameters, inverse_of: :filled_liquid_template, dependent: :destroy
  accepts_nested_attributes_for :filled_liquid_template_parameters, reject_if: :all_blank, allow_destroy: true
  validates :content, presence: true

  def set_from(liquid_template)
		self.content = liquid_template.content
		liquid_template.liquid_template_parameters.each do |liquid_template_parameter|
			self.filled_liquid_template_parameters.build(name: liquid_template_parameter.name)
		end
  end
end
