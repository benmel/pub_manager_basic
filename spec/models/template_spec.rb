require 'rails_helper'

RSpec.describe Template, type: :model do
  it 'has a valid factory' do
  	expect(build(:template)).to be_valid
  end

  describe 'associations' do
  	it { should belong_to(:user).inverse_of(:templates) }
  	it { should have_many(:template_parameters).inverse_of(:template).dependent(:destroy) }
  end

  describe 'presence validations' do
    before { allow(subject).to receive(:no_liquid_template_errors) }
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:content) }
  end

  describe 'Liquid validation' do
    it { should allow_value('Hello {{ name }}').for(:content) }
    it 'adds an error for invalid content' do
      template = build(:template, content: 'Hello {{ name }')
      template.valid?
      expect(template).not_to be_valid
      expect(template.errors).to have_key(:base)
    end
  end

  describe 'nested attributes' do
		it do
			should accept_nested_attributes_for(:template_parameters).
				allow_destroy(true)
		end
  end

  describe 'clean_content' do
    it 'should remove \r and \n from content' do
      template = build(:template, content: "Hello,\r\nHow are you?")
      expect(template.clean_content).to eq("Hello,How are you?")
    end
  end
end
