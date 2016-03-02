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

  describe 'section setters' do
    let(:liquid_template) { create(:liquid_template) }

    describe 'set_front_section_content_and_section_parameters_from(liquid_template)' do
      before(:each) { book.build_front_section }

      it 'should set the front_section content' do
        book.set_front_section_content_and_section_parameters_from(liquid_template)
        expect(book.front_section.content).to eq(liquid_template.content)
      end

      it 'should set the front_section section_parameters' do
        liquid_template_parameter = create(:liquid_template_parameter, liquid_template: liquid_template)
        book.set_front_section_content_and_section_parameters_from(liquid_template)
        expect(book.front_section.section_parameters.first.name).to eq(liquid_template_parameter.name)
      end
    end

    describe 'set_toc_section_content_and_section_parameters_from(liquid_template)' do
      before(:each) { book.build_toc_section }

      it 'should set the toc_section content' do
        book.set_toc_section_content_and_section_parameters_from(liquid_template)
        expect(book.toc_section.content).to eq(liquid_template.content)
      end

      it 'should set the toc_section section_parameters' do
        liquid_template_parameter = create(:liquid_template_parameter, liquid_template: liquid_template)
        book.set_toc_section_content_and_section_parameters_from(liquid_template)
        expect(book.toc_section.section_parameters.first.name).to eq(liquid_template_parameter.name)
      end
    end

    describe 'set_first_body_section_content_and_section_parameters_from(liquid_template)' do
      before(:each) { book.body_sections.build }

      it 'should set the first body section content' do
        book.set_first_body_section_content_and_section_parameters_from(liquid_template)
        expect(book.body_sections.first.content).to eq(liquid_template.content)
      end

      it 'should set the first body_section section_parameters' do
        liquid_template_parameter = create(:liquid_template_parameter, liquid_template: liquid_template)
        book.set_first_body_section_content_and_section_parameters_from(liquid_template)
        expect(book.body_sections.first.section_parameters.first.name).to eq(liquid_template_parameter.name)
      end
    end
  end
end
