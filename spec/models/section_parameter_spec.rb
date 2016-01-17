require 'rails_helper'

RSpec.describe SectionParameter, type: :model do
  it 'has a valid factory' do
  	expect(build(:section_parameter)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:section) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:name) }
  end
end
