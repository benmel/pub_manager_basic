class Book < ActiveRecord::Base
	belongs_to :project, inverse_of: :book
	has_one :front_section, inverse_of: :book, dependent: :destroy
	has_one :toc_section, inverse_of: :book, dependent: :destroy
	has_many :body_sections, inverse_of: :book, dependent: :destroy
	
	accepts_nested_attributes_for :front_section
	accepts_nested_attributes_for :toc_section
	accepts_nested_attributes_for :body_sections, reject_if: :all_blank

	def build_empty_book
		build_empty_front_section
		build_empty_toc_section
		build_empty_body_section
	end

	def build_empty_front_section
		build_front_section
		self.front_section.build_filled_liquid_template
	end

	def build_empty_toc_section
		build_toc_section
		self.toc_section.build_filled_liquid_template
	end

	def build_empty_body_section
		body_section = self.body_sections.build
		body_section.build_filled_liquid_template
	end

	def set_front_section_from(liquid_template)
		self.front_section.filled_liquid_template.set_from liquid_template
	end

	def set_toc_section_from(liquid_template)
		self.toc_section.filled_liquid_template.set_from liquid_template
	end

	def set_last_body_section_from(liquid_template)
		self.body_sections.last.filled_liquid_template.set_from liquid_template
	end
end
