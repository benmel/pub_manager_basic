class LiquidTemplate < ActiveRecord::Base
	belongs_to :user, inverse_of: :liquid_templates
	has_many :liquid_template_parameters, inverse_of: :liquid_template, dependent: :destroy
	accepts_nested_attributes_for :liquid_template_parameters, reject_if: :all_blank, allow_destroy: true
	enum template_type: {other: 0, description: 1, front_section: 2, toc_section: 3, body_section: 4}
	
	validates :name, presence: true
	validates :content, presence: true
	validates :template_type, presence: true
	validate :syntax_errors

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
