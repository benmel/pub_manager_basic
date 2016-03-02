require 'rails_helper'

RSpec.describe FilledLiquidTemplate, type: :model do
	it 'has a valid factory' do
  	expect(build(:filled_liquid_template)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:filled_liquid_templatable) }
  	it { should have_many(:filled_liquid_template_parameters).inverse_of(:filled_liquid_template).dependent(:destroy) }
  end
end
