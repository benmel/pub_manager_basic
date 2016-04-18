class Description < ActiveRecord::Base
  belongs_to :project, inverse_of: :description
  has_one :filled_liquid_template, as: :filled_liquid_templatable, dependent: :destroy
  accepts_nested_attributes_for :filled_liquid_template
  validates :content, presence: true

  def kindle
    self.filled_liquid_template.rendered_liquid_template(parameters_hash Marketplace::KINDLE)
  end

  def createspace
    self.filled_liquid_template.rendered_liquid_template(parameters_hash Marketplace::CREATESPACE)
  end

  def acx
    self.filled_liquid_template.rendered_liquid_template(parameters_hash Marketplace::ACX)
  end

  def parameters_hash(marketplace)
    [marketplace_hash(marketplace), project_hash, description_hash, chapters_hash].inject(:merge)
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
end
