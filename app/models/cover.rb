class Cover < ActiveRecord::Base
  belongs_to :project
  validates :photographer, presence: true
  validates :license, presence: true
end
