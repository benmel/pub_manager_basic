class Book < ActiveRecord::Base
  belongs_to :project, inverse_of: :book
  has_one :front_section, inverse_of: :book, dependent: :destroy
  has_one :toc_section, inverse_of: :book, dependent: :destroy
  has_many :sections, inverse_of: :book, dependent: :destroy
  
  accepts_nested_attributes_for :front_section
  accepts_nested_attributes_for :toc_section
  accepts_nested_attributes_for :sections, reject_if: :all_blank

  def set_front_section_content_and_section_parameters_from(template)
  	self.front_section.content = template.content
    template.template_parameters.each { |template_parameter| self.front_section.section_parameters.build(name: template_parameter.name) }
  end

  def set_toc_section_content_and_section_parameters_from(template)
  	self.toc_section.content = template.content
    template.template_parameters.each { |template_parameter| self.toc_section.section_parameters.build(name: template_parameter.name) }
  end

  def set_first_section_content_and_section_parameters_from(template)
  	self.sections.first.content = template.content
    template.template_parameters.each { |template_parameter| self.sections.first.section_parameters.build(name: template_parameter.name) }
  end
end
