require 'rails_helper'

RSpec.describe FrontSection, type: :model do
   it 'has a valid factory' do
  	expect(build(:front_section)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:book).inverse_of(:front_section) }
    it { should have_many(:section_parameters).inverse_of(:front_section).dependent(:destroy) }
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
