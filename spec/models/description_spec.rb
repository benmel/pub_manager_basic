require 'rails_helper'

RSpec.describe Description, type: :model do
  let(:description) { build(:description) }
  let(:description_with_valid_template) { create(:description_with_valid_template) }
  let(:description_with_marketplace_template) { create(:description_with_marketplace_template) }
  let(:description_with_parameters) { create(:description_with_parameters) }

  it 'has a valid factory' do
  	expect(build(:description)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project).inverse_of(:description) }
    it { should have_one(:filled_liquid_template).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:filled_liquid_template) }
  end

  describe 'presence validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'kindle' do
    it 'renders a Liquid template for Kindle' do
      expect(description_with_marketplace_template.kindle).to eq('kindle content')
    end
  end

  describe 'createspace' do
    it 'renders a Liquid template for Createspace' do
      expect(description_with_marketplace_template.createspace).to eq('createspace content')
    end
  end

  describe 'acx' do
    it 'renders a Liquid template for ACX' do
      expect(description_with_marketplace_template.acx).to eq('acx content')
    end
  end

  describe 'parsed_liquid_template' do
    it 'returns a Liquid template' do
      expect(description_with_valid_template.parsed_liquid_template).to be_a(Liquid::Template)
    end
  end

  describe 'parameters_hash(marketplace)' do
    before do
      allow(description).to receive(:project_hash).and_return({})
      allow(description).to receive(:description_hash).and_return({})
      allow(description).to receive(:chapters_hash).and_return({})
      allow(description).to receive(:filled_liquid_template_parameters_hash).and_return({})
    end

    it 'creates a hash with the marketplace' do
      expect(description.parameters_hash('random')).to eq({ 'marketplace' => 'random' })
    end
  end

  describe 'marketplace_hash(marketplace)' do
    it 'creates a hash using the marketplace parameter' do
      expect(description.marketplace_hash('random')).to eq({ 'marketplace' => 'random' })
    end
  end

  describe 'project_hash' do
    let(:project) { build(:project) }
    let(:description) { build(:description, project: project) }
    it 'creates a hash using the project attributes' do
      expect(description.project_hash).to eq({ 'title' => project.title, 'subtitle' => project.subtitle, 'author' => project.author })
    end
  end

  describe 'description_hash' do
    it 'creates a hash using the description attributes' do
      expect(description.description_hash).to eq({ 'content' => description.content, 'excerpt' => description.excerpt })
    end
  end

  describe 'chapters_hash' do
    it 'creates a hash using the chapter list' do
      expect(description.chapters_hash).to eq({ 'chapters' => description.chapter_list.split(';') })
    end
  end

  describe 'filled_liquid_template_parameters_hash' do
    it 'creates a hash using the filled_liquid_template_parameters' do
      expect(description_with_parameters.filled_liquid_template_parameters_hash).to eq(description_with_parameters.filled_liquid_template.filled_liquid_template_parameters.pluck(:name, :value).to_h)
    end
  end
end
