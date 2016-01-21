class SectionParameter < ActiveRecord::Base
  belongs_to :section, inverse_of: :section_parameters
  validates :name, presence: true
end
