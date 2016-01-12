require 'rails_helper'

RSpec.describe Template, type: :model do
  it 'has a valid factory' do
  	expect(build(:template)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:user) }
  	it { should have_many(:parameters).dependent(:destroy) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:content) }
  end

  describe 'nested attributes' do
		it do
			should accept_nested_attributes_for(:parameters).
				allow_destroy(true)
		end
  end
end
