require 'rails_helper'

RSpec.describe Book, type: :model do
    it 'has a valid factory' do
  	expect(build(:book)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project) }
    it { should have_many(:sections).dependent(:destroy) }
  end

  describe 'presence validations' do
	  it { should validate_presence_of(:content) }
  end
end
