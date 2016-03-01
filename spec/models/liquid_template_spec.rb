require 'rails_helper'

RSpec.describe LiquidTemplate, type: :model do
  it 'has a valid factory' do
  	expect(build(:liquid_template)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:user).inverse_of(:liquid_templates) }
  	it { should have_many(:liquid_template_parameters).inverse_of(:liquid_template).dependent(:destroy) }
  end

  describe 'enum' do
    it { should define_enum_for(:template_type).with([:other, :description, :front_section, :toc_section, :section]) }
  end

  describe 'presence validations' do
    before { allow(subject).to receive(:syntax_errors) }
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:content) }
    it { should validate_presence_of(:template_type) }
  end

  describe 'Liquid validation' do
    it { should allow_value('Hello {{ name }}').for(:content) }
    it 'adds an error for invalid content' do
      liquid_template = build(:liquid_template, content: 'Hello {{ name }')
      liquid_template.valid?
      expect(liquid_template).not_to be_valid
      expect(liquid_template.errors).to have_key(:content)
    end
  end

  describe 'nested attributes' do
		it do
			should accept_nested_attributes_for(:liquid_template_parameters).allow_destroy(true)
		end
  end

  describe 'sanitize_content' do
    it 'should remove \r and \n from content' do
      liquid_template = build(:liquid_template, content: "Hello,\r\nHow are you?")
      expect(liquid_template.sanitize_content).to eq("Hello,How are you?")
    end
  end
end
