require 'rails_helper'

RSpec.describe FrontSection, type: :model do
   it 'has a valid factory' do
  	expect(build(:front_section)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:book).inverse_of(:front_section) }
    it { should have_one(:filled_liquid_template).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:filled_liquid_template) }
  end
end
