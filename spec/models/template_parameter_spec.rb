require 'rails_helper'

RSpec.describe TemplateParameter, type: :model do
  it 'has a valid factory' do
  	expect(build(:template_parameter)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:template).inverse_of(:template_parameters) }
  end

  describe 'validations' do
  	it { should validate_presence_of(:name) }
  end
end
