require 'rails_helper'

RSpec.describe LiquidTemplatesController, type: :controller do
  render_views

  before(:each) do
    @user ||= create(:user)
    sign_in @user
  end

  let(:liquid_template) { create(:liquid_template, user: @user) }

  describe "GET #index" do
    before(:each) do
      liquid_template # need to create liquid template before get
      get :index
    end

    it 'assigns @liquid_templates' do
      expect(assigns(:liquid_templates)).to eq([liquid_template])
    end

    it 'renders the #index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before(:each) { get :show, id: liquid_template }

    it 'assigns @liquid_template' do
      expect(assigns(:liquid_template)).to eq(liquid_template)
    end

    it 'renders the #show template' do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    before(:each) { get :new }

    it 'assigns a new @liquid_template' do
      expect(assigns(:liquid_template)).to be_a_new(LiquidTemplate)
    end

    it 'renders the #new template' do
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before(:each) { get :edit, id: liquid_template }

    it 'assigns @liquid_template' do
      expect(assigns(:liquid_template)).to eq(liquid_template)
    end

    it 'renders the #edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      before(:each) do
        post :create, liquid_template: attributes_for(:liquid_template, :valid_content)
      end

      it 'creates the liquid template' do
        expect(LiquidTemplate.count).to eq(1)
      end

      it 'redirects to #show for the new liquid template' do
        expect(response).to redirect_to(LiquidTemplate.first)
      end
    end

    context 'with invalid attributes' do
      before :each do
        post :create, liquid_template: attributes_for(:liquid_template, :invalid_content)
      end

      it 'does not create the liquid template' do
        expect(LiquidTemplate.count).to eq(0)
      end

      it 'renders the #new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context 'with valid attributes' do
      before(:each) do
        patch :update, id: liquid_template, liquid_template: attributes_for(:liquid_template, :valid_content)
      end
      
      it 'updates the liquid template' do
        expect(liquid_template.reload.content).to eq('Hello {{ name }}')
      end

      it 'redirects to #show the updated liquid template' do
        expect(response).to redirect_to(liquid_template)
      end
    end

    context 'with invalid attributes' do
      before :each do
        @liquid_template_invalid = build(:liquid_template, :invalid_content)
        patch :update, id: liquid_template, liquid_template: @liquid_template_invalid.attributes
      end

      it 'does not update the liquid template' do
        expect(liquid_template.reload.content).to_not eq(@liquid_template_invalid.content)
      end

      it 'renders the #edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { delete :destroy, id: liquid_template }

    it 'deletes the liquid template' do
      expect(LiquidTemplate.count).to eq(0)
    end

    it 'redirects to liquid_templates_path' do
      expect(response).to redirect_to(liquid_templates_path)
    end
  end

  describe 'different user' do
    it 'raises an error' do
      sign_in create(:user)
      expect { get :show, id: liquid_template }.to raise_error(ActiveRecord::RecordNotFound) 
    end
  end
end
