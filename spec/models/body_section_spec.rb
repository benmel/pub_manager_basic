require 'rails_helper'

RSpec.describe BodySection, type: :model do
	it 'has a valid factory' do
		expect(build(:body_section)).to be_valid
	end

	describe 'associations' do
		it { should belong_to(:book).inverse_of(:body_sections) }
		it { should have_one(:filled_liquid_template).dependent(:destroy) }
	end

	describe 'nested attributes' do
		it { should accept_nested_attributes_for(:filled_liquid_template) }
	end

	describe 'presence validations' do
		it { should validate_presence_of(:content) }
		it { should validate_presence_of(:name) }
	end

	describe 'ranked-model' do
		it { should have_db_column(:row_order).of_type(:integer) }
	end
end
