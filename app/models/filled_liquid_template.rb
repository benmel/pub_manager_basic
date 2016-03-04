class FilledLiquidTemplate < ActiveRecord::Base
	belongs_to :filled_liquid_templatable, polymorphic: true
	has_many :filled_liquid_template_parameters, inverse_of: :filled_liquid_template, dependent: :destroy
	accepts_nested_attributes_for :filled_liquid_template_parameters, reject_if: :all_blank, allow_destroy: true
	validates :content, presence: true
	validate :syntax_errors

	def set_from(liquid_template)
		self.content = liquid_template.content
		liquid_template.liquid_template_parameters.each do |liquid_template_parameter|
			self.filled_liquid_template_parameters.build(name: liquid_template_parameter.name)
		end
	end

	def parsed_liquid_template
		@parsed_liquid_template ||= Liquid::Template.parse(sanitized_content)
	end

	def filled_liquid_template_parameters_hash
		@filled_liquid_template_parameters_hash ||= self.filled_liquid_template_parameters.pluck(:name, :value).to_h
	end

	private
	def syntax_errors
		Liquid::Template.parse(sanitized_content)
	rescue Liquid::SyntaxError => e
		errors.add(:content, e.message)
	end

	def sanitized_content
		@sanitized_content ||= self.content.delete("\r").delete("\n") if self.content
	end
end
