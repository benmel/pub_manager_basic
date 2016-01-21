require 'rails_helper'

RSpec.describe Cover, type: :model do
  it 'has a valid factory' do
  	expect(build(:cover)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:project).inverse_of(:cover) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:photographer) }
  	it { should validate_presence_of(:license) }
  end
end
