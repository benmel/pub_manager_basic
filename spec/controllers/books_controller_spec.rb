require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views

  before(:each) do
    @user ||= create(:user_with_projects)
    @front_template ||= create(:template, template_type: :front_section, user: @user)
    @toc_template ||= create(:template, template_type: :toc_section, user: @user)
    @content_template ||= create(:template, template_type: :section, user: @user)
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

      it 'builds a section' do
        expect(assigns(:book).sections.first).to_not be_nil
      end

      it 'assigns @front_templates, @toc_templates and @content_templates' do
        expect(assigns(:front_templates)).to eq([@front_template])
        expect(assigns(:toc_templates)).to eq([@toc_template])
        expect(assigns(:content_templates)).to eq([@content_template])
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

      it 'assigns @front_templates, @toc_templates and @content_templates' do
        expect(assigns(:front_templates)).to eq([@front_template])
        expect(assigns(:toc_templates)).to eq([@toc_template])
        expect(assigns(:content_templates)).to eq([@content_template])
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

  describe 'GET #form' do
    it 'assigns @project' do
      get :form, project_id: book_with_project.project
      expect(assigns(:project)).to eq(book_with_project.project)
    end

    context 'book exists' do
      before(:each) { get :form, project_id: book_with_project.project }
  
      it 'assigns @front_templates, @toc_templates and @content_templates' do
        expect(assigns(:front_templates)).to eq([@front_template])
        expect(assigns(:toc_templates)).to eq([@toc_template])
        expect(assigns(:content_templates)).to eq([@content_template])
      end

      it 'assigns @book' do
        expect(assigns(:book)).to eq(book_with_project)
      end

      it 'renders the form partial' do
        expect(response).to render_template(partial: '_form')
      end
    end

    context 'book does not exist' do
      it 'assigns a new @book' do
        get :form, project_id: project_without_book
        expect(assigns(:book)).to be_a_new(Book)
      end

      context 'does not include template_id param' do
        before(:each) { get :form, project_id: project_without_book }

        it 'assigns @front_templates, @toc_templates and @content_templates' do
          expect(assigns(:front_templates)).to eq([@front_template])
          expect(assigns(:toc_templates)).to eq([@toc_template])
          expect(assigns(:content_templates)).to eq([@content_template])
        end

        it 'renders the form partial' do
          expect(response).to render_template(partial: '_form')
        end
      end

      context 'includes template_id param' do
        context 'template does not exist' do
          it 'raises an error for wrong id' do
            expect { get :form, project_id: project_without_book, template_id: 'nil', section_type: 'front_section' }.to raise_error(ActiveRecord::RecordNotFound)
          end

          it 'raises an error for wrong section type' do
            expect { get :form, project_id: project_without_book, template_id: @front_template, section_type: 'toc_section' }.to raise_error(ActiveRecord::RecordNotFound)
          end

          it 'raises an error for invalid section type' do
            expect { get :form, project_id: project_without_book, template_id: @front_template, section_type: 'fake_section' }.to raise_error(NoMethodError) 
          end
        end

        context 'template exists' do
          it 'assigns @template' do
            get :form, project_id: project_without_book, template_id: @front_template, section_type: 'front_section'
            expect(assigns(:template)).to eq(@front_template)
          end

          context 'section_type param' do
            context 'is front_section' do
              before(:each) { get :form, project_id: project_without_book, template_id: @front_template, section_type: 'front_section' }

              it 'builds the front section' do
                expect(assigns(:book).front_section).to_not be_nil
              end

              it 'sets the front section content and section parameters' do
                expect(assigns(:book).front_section.content).to eq(@front_template.content)
              end

              it 'renders the wrapper_front partial' do
                expect(response).to render_template(partial: '_wrapper_front')
              end
            end

            context 'is toc_section' do
              before(:each) { get :form, project_id: project_without_book, template_id: @toc_template, section_type: 'toc_section' }

              it 'builds the toc section' do
                expect(assigns(:book).toc_section).to_not be_nil
              end

              it 'sets the toc section content and section parameters' do
                expect(assigns(:book).toc_section.content).to eq(@toc_template.content)
              end

              it 'renders the wrapper_toc partial' do
                expect(response).to render_template(partial: '_wrapper_toc')
              end
            end

            context 'is section' do
              before(:each) { get :form, project_id: project_without_book, template_id: @content_template, section_type: 'section' }

              it 'builds a section' do
                expect(assigns(:book).sections.first).to_not be_nil
              end

              it 'sets the section content and section parameters' do
                expect(assigns(:book).sections.first.content).to eq(@content_template.content)
              end

              it 'assigns @content_templates' do
                expect(assigns(:content_templates)).to eq([@content_template])
              end

              it 'renders the wrapper_sections partial' do
                expect(response).to render_template(partial: '_wrapper_sections')              
              end
            end

            context 'is something else' do
              before(:each) do
                other_template = create(:template, template_type: :other, user: @user)
                get :form, project_id: project_without_book, template_id: other_template, section_type: 'other'
              end

              it 'renders bad_request' do
                expect(response.status).to eq(400)
              end
            end
          end
        end

      end
    end
  end

  describe 'different user' do
    it 'raises an error' do
      sign_in create(:user)
      expect { 
        get :show, id: book_with_project 
      }.to raise_error(ActiveRecord::RecordNotFound) 
    end
  end
end
