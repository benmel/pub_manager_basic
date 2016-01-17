class Book < ActiveRecord::Base
  belongs_to :project
  has_many :sections, dependent: :destroy
  validates :content, presence: true
end
