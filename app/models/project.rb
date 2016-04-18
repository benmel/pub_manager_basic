class Project < ActiveRecord::Base
	belongs_to :user, inverse_of: :projects
	has_one :book, inverse_of: :project, dependent: :destroy
	has_one :cover, inverse_of: :project, dependent: :destroy
	has_one :description, inverse_of: :project, dependent: :destroy
	validates :title, presence: true
	validates :author, presence: true

  def project_hash
    @project_hash ||= self.attributes.slice('title', 'subtitle', 'author')
  end
end
