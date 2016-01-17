class Project < ActiveRecord::Base
	belongs_to :user
	has_one :book, dependent: :destroy
	has_one :cover, dependent: :destroy
	has_one :description, dependent: :destroy
	validates :title, presence: true
	validates :author, presence: true
end
