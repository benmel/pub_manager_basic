require 'rails_helper'

RSpec.describe FilledLiquidTemplateParameter, type: :model do
	it 'has a valid factory' do
		expect(build(:filled_liquid_template_parameter)).to be_valid
	end

	describe 'associations' do
		it { should belong_to(:filled_liquid_template).inverse_of(:filled_liquid_template_parameters) }
	end

	describe 'validations' do
		it { should validate_presence_of(:name) }
	end
end
