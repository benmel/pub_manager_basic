require 'rails_helper'

RSpec.describe LiquidTemplate, type: :model do
  it 'has a valid factory' do
  	expect(build(:liquid_template)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:user).inverse_of(:liquid_templates) }
  	it { should have_many(:liquid_template_parameters).inverse_of(:liquid_template).dependent(:destroy) }
  end

  describe 'nested attributes' do
		it { should accept_nested_attributes_for(:liquid_template_parameters).allow_destroy(true) }
  end

  describe 'enumerize' do
    it { should enumerize(:category).in(:other, :description, :front_section, :toc_section, :body_section).with_scope(true) }
  end

  describe 'presence validations' do
    before { allow(subject).to receive(:syntax_errors) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:category) }
  end

  describe 'Liquid validation' do
    it 'allows valid content' do
      liquid_template = build(:liquid_template, :valid_content)
      liquid_template.valid?
      expect(liquid_template).to be_valid
    end

    it 'adds an error for invalid content' do
      liquid_template = build(:liquid_template, :invalid_content)
      liquid_template.valid?
      expect(liquid_template).not_to be_valid
      expect(liquid_template.errors).to have_key(:content)
    end
  end
end
