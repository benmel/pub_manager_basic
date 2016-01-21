require 'rails_helper'

RSpec.describe User, type: :model do
	it 'has a valid factory' do
  	expect(build(:user)).to be_valid
  end

  describe 'associations' do
  	it { should have_many(:projects).inverse_of(:user).dependent(:destroy) }
  	it { should have_many(:templates).inverse_of(:user).dependent(:destroy) }
  end
end
