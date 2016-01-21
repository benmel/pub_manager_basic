class Description < ActiveRecord::Base
  belongs_to :project, inverse_of: :description
  has_many :filled_parameters, inverse_of: :description, dependent: :destroy
  validates :template, presence: true
  accepts_nested_attributes_for :filled_parameters, reject_if: lambda { |attributes| attributes[:name].blank? }, allow_destroy: true

  validate :no_liquid_template_errors

  def no_liquid_template_errors
    Liquid::Template.parse(clean_template)
  rescue Liquid::SyntaxError => e
    errors.add(:base, e.message)
  end

  def kindle
  	liquid_template.render(parameters_hash Marketplace::KINDLE)
  end

  def createspace
  	liquid_template.render(parameters_hash Marketplace::CREATESPACE)
  end

  def acx
  	liquid_template.render(parameters_hash Marketplace::ACX)
  end

  def liquid_template
  	@liquid_template ||= Liquid::Template.parse(clean_template)
  end

  def clean_template
  	@clean_template ||= self.template.delete("\r").delete("\n")
  end

  def parameters_hash(marketplace)
  	marketplace_hash = { 'marketplace' => marketplace }
  	[marketplace_hash, project_hash, description_hash, chapters_hash, filled_parameters_hash].inject(:merge)
  end

  def project_hash
  	@project_hash ||= self.project.attributes.slice('title', 'subtitle', 'author')
  end
  	
  def description_hash	
  	@description_hash ||= self.attributes.slice('content', 'excerpt')
  end

  def chapters_hash
  	@chapters_hash ||= { 'chapters' => self.chapter_list.split(';') }
  end

  def filled_parameters_hash
  	@filled_parameters_hash ||= self.filled_parameters.pluck(:name, :value).to_h
  end

  def set_template_and_filled_parameters_from(template)
    self.template = template.content
    template.parameters.each { |parameter| self.filled_parameters.build(name: parameter.name) }
  end
end
