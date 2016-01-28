class Template < ActiveRecord::Base
  belongs_to :user, inverse_of: :templates
  has_many :template_parameters, inverse_of: :template, dependent: :destroy
  accepts_nested_attributes_for :template_parameters, reject_if: :all_blank, allow_destroy: true
  enum template_type: {other: 0, description: 1, front_section: 2, toc_section: 3, section: 4}
  
  validates :name, presence: true
  validates :content, presence: true
  validates :template_type, presence: true
	validate :no_liquid_template_errors

  def no_liquid_template_errors
    Liquid::Template.parse(clean_content)
  rescue Liquid::SyntaxError => e
    errors.add(:base, e.message)
  end

  def clean_content
  	@clean_content ||= self.content.delete("\r").delete("\n")
  end
end
