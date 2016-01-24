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

  describe 'ranked-model' do
    it { should have_db_column(:row_order).of_type(:integer) }
  end
end
