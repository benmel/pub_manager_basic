require 'rails_helper'

RSpec.describe Book, type: :model do
    it 'has a valid factory' do
  	expect(build(:book)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project).inverse_of(:book) }
    it { should have_one(:front_section).inverse_of(:book).dependent(:destroy) }
    it { should have_one(:toc_section).inverse_of(:book).dependent(:destroy) }
    it { should have_many(:sections).inverse_of(:book).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:front_section) }
    it { should accept_nested_attributes_for(:toc_section) }
    it { should accept_nested_attributes_for(:sections) }
  end
end
