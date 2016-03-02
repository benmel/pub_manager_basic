class Book < ActiveRecord::Base
  belongs_to :project, inverse_of: :book
  has_one :front_section, inverse_of: :book, dependent: :destroy
  has_one :toc_section, inverse_of: :book, dependent: :destroy
  has_many :body_sections, inverse_of: :book, dependent: :destroy
  
  accepts_nested_attributes_for :front_section
  accepts_nested_attributes_for :toc_section
  accepts_nested_attributes_for :body_sections, reject_if: :all_blank

  def set_front_section_content_and_section_parameters_from(liquid_template)
  	self.front_section.content = liquid_template.content
    liquid_template.liquid_template_parameters.each { |liquid_template_parameter| self.front_section.section_parameters.build(name: liquid_template_parameter.name) }
  end

  def set_toc_section_content_and_section_parameters_from(liquid_template)
  	self.toc_section.content = liquid_template.content
    liquid_template.liquid_template_parameters.each { |liquid_template_parameter| self.toc_section.section_parameters.build(name: liquid_template_parameter.name) }
  end

  def set_first_body_section_content_and_section_parameters_from(liquid_template)
  	self.body_sections.first.content = liquid_template.content
    liquid_template.liquid_template_parameters.each { |liquid_template_parameter| self.body_sections.first.section_parameters.build(name: liquid_template_parameter.name) }
  end
end
