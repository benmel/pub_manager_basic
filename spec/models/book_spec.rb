require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  it 'has a valid factory' do
  	expect(build(:book)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project).inverse_of(:book) }
    it { should have_one(:front_section).inverse_of(:book).dependent(:destroy) }
    it { should have_one(:toc_section).inverse_of(:book).dependent(:destroy) }
    it { should have_many(:body_sections).inverse_of(:book).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:front_section) }
    it { should accept_nested_attributes_for(:toc_section) }
    it { should accept_nested_attributes_for(:body_sections) }
  end

	describe 'section builders' do
		describe 'build_empty_book' do
			it 'builds the sections' do
				book.build_empty_book
				expect(book.front_section).to_not be_nil
				expect(book.toc_section).to_not be_nil
				expect(book.body_sections.last).to_not be_nil
			end

			it 'builds the filled_liquid_templates' do
				book.build_empty_book
				expect(book.front_section.filled_liquid_template).to_not be_nil
        expect(book.toc_section.filled_liquid_template).to_not be_nil
			end
		end

		describe 'build_empty_front_section' do
			it 'builds the front_section' do
				book.build_empty_front_section
				expect(book.front_section).to_not be_nil
			end

			it 'builds the filled_liquid_template' do
				book.build_empty_front_section
				expect(book.front_section.filled_liquid_template).to_not be_nil
			end
		end

		describe 'build_empty_toc_section' do
			it 'builds the toc_section' do
				book.build_empty_toc_section
				expect(book.toc_section).to_not be_nil
			end

			it 'builds the filled_liquid_template' do
        book.build_empty_toc_section
        expect(book.toc_section.filled_liquid_template).to_not be_nil
			end
		end

		describe 'build_empty_body_section' do
			it 'builds a body_section' do
				book.build_empty_body_section
				expect(book.body_sections.last).to_not be_nil
			end

			it 'builds the filled_liquid_template' do
        book.build_empty_body_section
        expect(book.body_sections.last.filled_liquid_template).to_not be_nil
			end
		end
  end
end
