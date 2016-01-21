class Template < ActiveRecord::Base
  belongs_to :user, inverse_of: :templates
  has_many :template_parameters, inverse_of: :template, dependent: :destroy
  validates :name, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :template_parameters, reject_if: lambda { |attributes| attributes[:name].blank? }, allow_destroy: true

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
