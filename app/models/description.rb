class Description < ActiveRecord::Base
  belongs_to :project
  has_many :filled_parameters, dependent: :destroy
  validates :template, presence: true
  accepts_nested_attributes_for :filled_parameters, reject_if: lambda { |attributes| attributes[:name].blank? }, allow_destroy: true
end
