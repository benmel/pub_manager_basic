require 'rails_helper'

RSpec.describe Section, type: :model do
  it 'has a valid factory' do
    expect(build(:section)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:book).inverse_of(:sections) }
    it { should have_many(:section_parameters).inverse_of(:section).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:section_parameters).allow_destroy(true) }
  end

  describe 'presence validations' do
	  it { should validate_presence_of(:name) }
    it { should validate_presence_of(:content) }
  end

  describe 'Liquid validation' do
    it { should allow_value('Hello {{ name }}').for(:content) }
    it 'adds an error for an invalid content' do
      invalid_content = Section.new(content: 'Hello {{ name')
      invalid_content.valid?
      expect(invalid_content).to_not be_valid
      expect(invalid_content.errors).to have_key(:content)
    end
  end

  describe 'ranked-model' do
    it { should have_db_column(:row_order).of_type(:integer) }
  end
end
