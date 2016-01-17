class Section < ActiveRecord::Base
  belongs_to :book
  has_many :section_parameters, dependent: :destroy
  accepts_nested_attributes_for :section_parameters, reject_if: lambda { |attributes| attributes[:name].blank? }, allow_destroy: true
  validates :content, presence: true
end
