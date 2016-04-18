class Description < ActiveRecord::Base
  belongs_to :project, inverse_of: :description
  has_one :filled_liquid_template, as: :filled_liquid_templatable, dependent: :destroy
  accepts_nested_attributes_for :filled_liquid_template
  validates :content, presence: true

  def kindle
    parsed_liquid_template.render(parameters_hash Marketplace::KINDLE)
  end

  def createspace
  	parsed_liquid_template.render(parameters_hash Marketplace::CREATESPACE)
  end

  def acx
  	parsed_liquid_template.render(parameters_hash Marketplace::ACX)
  end

  # TODO: move this to filled_liquid_template
  def parsed_liquid_template
    @parsed_liquid_template ||= self.filled_liquid_template.parsed_liquid_template
  end

  def parameters_hash(marketplace)
  	[marketplace_hash(marketplace), project_hash, description_hash, chapters_hash, filled_liquid_template_parameters_hash].inject(:merge)
  end

  def marketplace_hash(marketplace)
    { 'marketplace' => marketplace }
  end

  # TODO: move this to project model
  def project_hash
  	@project_hash ||= self.project.attributes.slice('title', 'subtitle', 'author')
  end
  	
  def description_hash	
  	@description_hash ||= self.attributes.slice('content', 'excerpt')
  end

  def chapters_hash
  	@chapters_hash ||= { 'chapters' => self.chapter_list.split(';') }
  end

  def filled_liquid_template_parameters_hash
    @filled_liquid_template_parameters_hash ||= self.filled_liquid_template.filled_liquid_template_parameters_hash
  end
end
