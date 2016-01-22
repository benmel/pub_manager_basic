class SectionParameter < ActiveRecord::Base
  belongs_to :section, inverse_of: :section_parameters
  belongs_to :front_section, inverse_of: :section_parameters
  belongs_to :toc_section, inverse_of: :section_parameters
  validates :name, presence: true
end
