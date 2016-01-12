require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do
  before(:each) do
    @user ||= create(:user)
    sign_in @user
  end

  let(:template) { create(:template, user: @user) }

  describe "GET #index" do
    before(:each) { get :index }

    it 'assigns @templates' do
      expect(assigns(:templates)).to eq([template])
    end

    it 'renders the #index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before(:each) { get :show, id: template }

    it 'assigns @template' do
      expect(assigns(:template)).to eq(template)
    end

    it 'renders the #show template' do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    before(:each) { get :new }

    it 'assigns a new @template' do
      expect(assigns(:template)).to be_a_new(Template)
    end

    it 'renders the #new template' do
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before(:each) { get :edit, id: template }

    it 'assigns @template' do
      expect(assigns(:template)).to eq(template)
    end

    it 'renders the #edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      before(:each) { post :create, template: attributes_for(:template) }

      it 'creates the template' do
        expect(Template.count).to eq(1)
      end

      it 'redirects to #show for the new template' do
        expect(response).to redirect_to(Template.first)
      end
    end

    context 'with invalid attributes' do
      before(:each) { post :create, template: attributes_for(:template, content: nil) }

      it 'does not create the template' do
        expect(Template.count).to eq(0)
      end

      it 'renders the #new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context 'with valid attributes' do
      before(:each) { patch :update, id: template, template: attributes_for(:template, name: 'New Name') }
      
      it 'updates the template' do
        expect(template.reload.name).to eq('New Name')
      end

      it 'redirects to #show the updated template' do
        expect(response).to redirect_to(template)
      end
    end

    context 'with invalid attributes' do
      before(:each) { patch :update, id: template, template: attributes_for(:template, name: '') }

      it 'does not update the template' do
        expect(template.name).to eq(template.reload.name)
      end

      it 'renders the #edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { delete :destroy, id: template }

    it 'deletes the template' do
      expect(Template.count).to eq(0)
    end

    it 'redirects to templates_path' do
      expect(response).to redirect_to(templates_path)
    end
  end

  describe 'different user' do
    it 'raises an error' do
      sign_in create(:user)
      expect { 
        get :show, id: template 
      }.to raise_error(ActiveRecord::RecordNotFound) 
    end
  end
end
