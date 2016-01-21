class FilledParameter < ActiveRecord::Base
  belongs_to :description, inverse_of: :filled_parameters
	validates :name, presence: true
end
