require 'rails_helper'

RSpec.describe Description, type: :model do
  let(:description) { build(:description) }
  let(:description_with_valid_template) { build(:description, :valid_template) }
  let(:description_with_invalid_template) { build(:description, :invalid_template) }
  let(:description_with_marketplace_template) { build(:description, :marketplace_template) }
  let(:description_with_filled_parameters) { create(:description_with_filled_parameters) }

  it 'has a valid factory' do
  	expect(build(:description)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:project).inverse_of(:description) }
    it { should have_many(:filled_parameters).inverse_of(:description).dependent(:destroy) }
  end

  describe 'presence validations' do
    before { allow(subject).to receive(:no_liquid_template_errors) }
	  it { should validate_presence_of(:template) }
  end

  describe 'Liquid validation' do
    it { should allow_value('Hello {{ name }}').for(:template) }
    it 'adds an error for an invalid template' do
      description_with_invalid_template.valid?
      expect(description_with_invalid_template).to_not be_valid
      expect(description_with_invalid_template.errors).to have_key(:base)
    end
  end

  describe 'nested attributes' do
    it do
      should accept_nested_attributes_for(:filled_parameters).
        allow_destroy(true)
    end
  end

  describe 'kindle' do
    before { allow(description_with_marketplace_template).to receive(:parameters_hash).with('kindle').and_return({ 'marketplace' => 'kindle' }) }
    it 'should render a Liquid template for Kindle' do
      expect(description_with_marketplace_template.kindle).to eq('kindle content')
    end
  end

  describe 'createspace' do
    before { allow(description_with_marketplace_template).to receive(:parameters_hash).with('createspace').and_return({ 'marketplace' => 'createspace' }) }
    it 'should render a Liquid template for Createspace' do
      expect(description_with_marketplace_template.createspace).to eq('createspace content')
    end
  end

  describe 'acx' do
    before { allow(description_with_marketplace_template).to receive(:parameters_hash).with('acx').and_return({ 'marketplace' => 'acx' }) }
    it 'should render a Liquid template for ACX' do
      expect(description_with_marketplace_template.acx).to eq('acx content')
    end
  end

  describe 'liquid_template' do
    context 'valid template' do
      it 'should create a Liquid template' do
        expect(description_with_valid_template.liquid_template).to be_a(Liquid::Template)
      end
    end

    context 'invalid template' do
      it 'should raise a SyntaxError' do
        expect { description_with_invalid_template.liquid_template }.to raise_error(Liquid::SyntaxError)
      end
    end
  end

  describe 'clean_template' do
    it 'should remove \r and \n from content' do
      description = build(:description, template: "Hello,\r\nHow are you?")
      expect(description.clean_template).to eq("Hello,How are you?")
    end
  end

  describe 'parameters_hash(marketplace)' do
    before do
      allow(description).to receive(:project_hash).and_return({})
      allow(description).to receive(:description_hash).and_return({})
      allow(description).to receive(:chapters_hash).and_return({})
      allow(description).to receive(:filled_parameters_hash).and_return({})
    end

    it 'should create a hash with the marketplace' do
      expect(description.parameters_hash('random')).to eq({ 'marketplace' => 'random' })
    end
  end

  describe 'project_hash' do
    let(:project) { build(:project) }
    let(:description) { build(:description, project: project) }
    it 'should create a hash using the project attributes' do
      expect(description.project_hash).to eq({ 'title' => project.title, 'subtitle' => project.subtitle, 'author' => project.author })
    end
  end

  describe 'description_hash' do
    it 'should create a hash using the description attributes' do
      expect(description.description_hash).to eq({ 'content' => description.content, 'excerpt' => description.excerpt })
    end
  end

  describe 'chapters_hash' do
    it 'should create a hash using the chapter list' do
      expect(description.chapters_hash).to eq({ 'chapters' => description.chapter_list.split(';') })
    end
  end

  describe 'filled_parameters_hash' do
    it 'should create a hash using the filled parameters' do
      expect(description_with_filled_parameters.filled_parameters_hash).to eq(description_with_filled_parameters.filled_parameters.pluck(:name, :value).to_h)
    end
  end

  describe 'set_template_and_filled_parameters_from(template)' do
    let(:template) { create(:template) }

    it 'should set the template' do
      description.set_template_and_filled_parameters_from(template)
      expect(description.template).to eq(template.content)
    end

    it 'should set the filled parameters' do
      parameter = create(:parameter, template: template)
      description.set_template_and_filled_parameters_from(template)
      expect(description.filled_parameters.first.name).to eq(parameter.name)
    end
  end
end
