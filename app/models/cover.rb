class Cover < ActiveRecord::Base
  belongs_to :project, inverse_of: :cover
  validates :photographer, presence: true
  validates :license, presence: true
end
