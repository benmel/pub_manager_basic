require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'has a valid factory' do
  	expect(build(:project)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:user).inverse_of(:projects) }
		it { should have_one(:book).inverse_of(:project).dependent(:destroy) }
    it { should have_one(:cover).inverse_of(:project).dependent(:destroy) }
    it { should have_one(:description).inverse_of(:project).dependent(:destroy) }
  end

  describe 'validations' do
	  it { should validate_presence_of(:title) }
	  it { should validate_presence_of(:author) }
  end
end
