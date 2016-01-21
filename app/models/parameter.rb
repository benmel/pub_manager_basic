class Parameter < ActiveRecord::Base
  belongs_to :template, inverse_of: :parameters
  validates :name, presence: true
end
