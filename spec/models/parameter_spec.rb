require 'rails_helper'

RSpec.describe Parameter, type: :model do
  it 'has a valid factory' do
  	expect(build(:parameter)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:template).inverse_of(:parameters) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:name) }
  end
end
