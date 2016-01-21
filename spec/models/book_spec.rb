require 'rails_helper'

RSpec.describe Book, type: :model do
    it 'has a valid factory' do
  	expect(build(:book)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project).inverse_of(:book) }
    it { should have_many(:sections).inverse_of(:book).dependent(:destroy) }
  end

  describe 'presence validations' do
	  it { should validate_presence_of(:content) }
  end
end
