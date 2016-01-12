class Template < ActiveRecord::Base
  belongs_to :user
  has_many :parameters, dependent: :destroy
  validates :name, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :parameters, reject_if: lambda { |attributes| attributes[:name].blank? }, allow_destroy: true
end
