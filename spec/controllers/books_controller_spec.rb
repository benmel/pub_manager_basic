require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views

  before(:each) do
    @user ||= create(:user_with_projects)
    @front_liquid_template ||= create(:liquid_template, category: :front_section, user: @user)
    @toc_liquid_template ||= create(:liquid_template, category: :toc_section, user: @user)
    @body_liquid_template ||= create(:liquid_template, category: :body_section, user: @user)
    sign_in @user
  end

  let(:book_with_project) { create(:book, project: @user.projects.first) }
  let(:project_without_book) { @user.projects.second }

  describe "GET #index" do
    before(:each) do
      book_with_project
      get :index
    end
    
    it 'assigns @books' do
      expect(assigns(:books)).to eq([book_with_project])
    end

    it 'renders the #index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    context 'book exists' do
      before(:each) { get :show, id: book_with_project }

      it 'assigns @book' do
        expect(assigns(:book)).to eq(book_with_project)
      end

      it 'renders the #show template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "GET #new" do
    context 'book exists' do
      it 'redirects to #show for the book' do
        get :new, project_id: book_with_project.project
        expect(response).to redirect_to(book_with_project)
      end
    end

    context 'book does not exist' do
      before(:each) { get :new, project_id: project_without_book }

      it 'assigns a new @book' do
        expect(assigns(:book)).to be_a_new(Book)
      end

      it 'builds a front_section' do
        expect(assigns(:book).front_section).to_not be_nil
      end

      it 'builds a toc_section' do
        expect(assigns(:book).toc_section).to_not be_nil
      end

      it 'builds a body section' do
        expect(assigns(:book).body_sections.first).to_not be_nil
      end

      it 'assigns @front_liquid_templates, @toc_liquid_templates and @body_liquid_templates' do
        expect(assigns(:front_liquid_templates)).to eq([@front_liquid_template])
        expect(assigns(:toc_liquid_templates)).to eq([@toc_liquid_template])
        expect(assigns(:body_liquid_templates)).to eq([@body_liquid_template])
      end

      it 'renders the #new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      before(:each) do
        post :create, project_id: project_without_book, book: build(:book).attributes
      end

      it 'creates the book' do
        expect(Book.count).to eq(1)
      end

      it 'redirects to #show for the book' do
        expect(response).to redirect_to(Book.first)
      end
    end

    context 'with invalid attributes' do
      before :each do
        allow_any_instance_of(Book).to receive(:save).and_return(false)
        post :create, project_id: project_without_book, book: build(:book).attributes
      end

      it 'does not create the book' do
        expect(Book.count).to eq(0)
      end

      it 'assigns @front_liquid_templates, @toc_liquid_templates and @body_liquid_templates' do
        expect(assigns(:front_liquid_templates)).to eq([@front_liquid_template])
        expect(assigns(:toc_liquid_templates)).to eq([@toc_liquid_template])
        expect(assigns(:body_liquid_templates)).to eq([@body_liquid_template])
      end

      it 'renders the #new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { delete :destroy, id: book_with_project }

    it 'deletes the book' do
      expect(Book.count).to eq(0)
    end

    it 'redirects to #show for the project' do
      expect(response).to redirect_to(book_with_project.project)
    end
  end

  describe 'different user' do
    it 'raises an error' do
      sign_in create(:user)
      expect { get :show, id: book_with_project }.to raise_error(ActiveRecord::RecordNotFound) 
    end
  end
end
