class LiquidTemplate < ActiveRecord::Base
	belongs_to :user, inverse_of: :liquid_templates
	has_many :liquid_template_parameters, inverse_of: :liquid_template, dependent: :destroy
	accepts_nested_attributes_for :liquid_template_parameters, reject_if: :all_blank, allow_destroy: true

	extend Enumerize
	enumerize :category, in: [:other, :description, :front_section, :toc_section, :body_section], scope: true
	
	validates :name, presence: true
	validates :content, presence: true
	validates :category, presence: true
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
