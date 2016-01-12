require 'rails_helper'

RSpec.describe FilledParameter, type: :model do
  it 'has a valid factory' do
  	expect(build(:filled_parameter)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:description) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:name) }
  end
end
