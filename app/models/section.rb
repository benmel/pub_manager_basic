class Section < ActiveRecord::Base
  belongs_to :book, inverse_of: :sections
  has_many :section_parameters, inverse_of: :section, dependent: :destroy
  accepts_nested_attributes_for :section_parameters, reject_if: lambda { |attributes| attributes[:name].blank? }, allow_destroy: true
  validates :content, presence: true
end
