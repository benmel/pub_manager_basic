class DescriptionParameter < ActiveRecord::Base
  belongs_to :description
	validates :name, presence: true
end
