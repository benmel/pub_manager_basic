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

	describe 'set_from(liquid_template)' do
		let(:liquid_template) { build(:liquid_template) }
		let(:filled_liquid_template) { create(:filled_liquid_template) }

		it 'should set the content' do
			filled_liquid_template.set_from(liquid_template)
			expect(filled_liquid_template.content).to eq(liquid_template.content)
		end

		it 'should set the filled_liquid_template_parameters' do
			liquid_template_parameter = create(:liquid_template_parameter, liquid_template: liquid_template)
			filled_liquid_template.set_from(liquid_template)
			expect(filled_liquid_template.filled_liquid_template_parameters.first.name).to eq(liquid_template_parameter.name)
		end
	end

	describe 'parsed_liquid_template' do
		it 'returns a Liquid template' do
			expect(filled_liquid_template.parsed_liquid_template).to be_a(Liquid::Template)
		end
	end

	describe 'sanitized_content' do
		it 'should remove \r and \n from content' do
			filled_liquid_template.content = "Hello,\r\nHow are you?"
			expect(filled_liquid_template.sanitized_content).to eq("Hello,How are you?")
		end
	end

	describe 'filled_liquid_template_parameters_hash' do
		it 'creates a hash using the filled_liquid_template_parameters' do
			expect(filled_liquid_template_with_parameters.filled_liquid_template_parameters_hash).to eq(filled_liquid_template_with_parameters.filled_liquid_template_parameters.pluck(:name, :value).to_h)
		end
	end
end
