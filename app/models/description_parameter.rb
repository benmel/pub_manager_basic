class DescriptionParameter < ActiveRecord::Base
  belongs_to :description, inverse_of: :description_parameters
	validates :name, presence: true
end
