class Project < ActiveRecord::Base
	has_one :cover, dependent: :destroy
	validates :title, presence: true
	validates :author, presence: true
end
