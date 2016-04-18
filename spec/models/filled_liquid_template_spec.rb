require 'rails_helper'

RSpec.describe FilledLiquidTemplate, type: :model do
	let (:filled_liquid_template) { build(:filled_liquid_template) }
	let (:filled_liquid_template_with_parameters) { create(:filled_liquid_template_with_parameters) }

	it 'has a valid factory' do
  	expect(build(:filled_liquid_template)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:filled_liquid_templatable) }
  	it { should have_many(:filled_liquid_template_parameters).inverse_of(:filled_liquid_template).dependent(:destroy) }
  end

	describe 'nested attributes' do
		it { should accept_nested_attributes_for(:filled_liquid_template_parameters).allow_destroy(true) }
	end

  describe 'presence validations' do
		it { should validate_presence_of(:content) }
	end

  describe 'Liquid validation' do
    it 'allows valid content' do
      filled_liquid_template_valid = build(:filled_liquid_template, :valid_content)
      filled_liquid_template_valid.valid?
      expect(filled_liquid_template_valid).to be_valid
    end

    it 'adds an error for invalid content' do
      filled_liquid_template_invalid = build(:filled_liquid_template, :invalid_content)
      filled_liquid_template_invalid.valid?
      expect(filled_liquid_template_invalid).not_to be_valid
      expect(filled_liquid_template_invalid.errors).to have_key(:content)
    end
  end

	describe 'parsed_liquid_template' do
		it 'returns a Liquid template' do
			expect(filled_liquid_template.parsed_liquid_template).to be_a(Liquid::Template)
		end
	end

	describe 'filled_liquid_template_parameters_hash' do
		it 'creates a hash using the filled_liquid_template_parameters' do
			expect(filled_liquid_template_with_parameters.filled_liquid_template_parameters_hash).to eq(filled_liquid_template_with_parameters.filled_liquid_template_parameters.pluck(:name, :value).to_h)
		end
	end
end
