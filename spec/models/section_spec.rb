require 'rails_helper'

RSpec.describe Section, type: :model do
  it 'has a valid factory' do
  	expect(build(:section)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:book) }
    it { should have_many(:section_parameters).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it do
      should accept_nested_attributes_for(:section_parameters).
        allow_destroy(true)
    end
  end

  describe 'presence validations' do
	  it { should validate_presence_of(:content) }
  end
end
