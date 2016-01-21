require 'rails_helper'

RSpec.describe DescriptionParameter, type: :model do
  it 'has a valid factory' do
  	expect(build(:description_parameter)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:description).inverse_of(:description_parameters) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:name) }
  end
end
