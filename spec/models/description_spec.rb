require 'rails_helper'

RSpec.describe Description, type: :model do
  it 'has a valid factory' do
  	expect(build(:description)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project) }
    it { should have_many(:filled_parameters).dependent(:destroy) }
  end

  describe 'validations' do
	  it { should validate_presence_of(:template) }
  end

  describe 'nested attributes' do
    it do
      should accept_nested_attributes_for(:filled_parameters).
        allow_destroy(true)
    end
  end
end
