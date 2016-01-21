class Book < ActiveRecord::Base
  belongs_to :project, inverse_of: :book
  has_many :sections, inverse_of: :book, dependent: :destroy
  validates :content, presence: true
end
