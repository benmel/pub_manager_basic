require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
	let(:project) { create(:project) }

	describe 'GET #index' do
		before(:each) { get :index }

		it 'assigns @projects' do
			expect(assigns(:projects)).to eq([project])
		end

		it 'renders the #index template' do
			expect(response).to render_template(:index)
		end
	end

	describe 'GET #show' do
		before(:each) { get :show, id: project }

		it 'assigns @project' do
			expect(assigns(:project)).to eq(project)
		end

		it 'renders the #show template' do
			expect(response).to render_template(:show)
		end
	end

	describe 'GET #new' do
		before(:each) { get :new }

		it 'assigns a new @project' do
			expect(assigns(:project)).to be_a_new(Project)
		end

		it 'renders the #new template' do
			expect(response).to render_template(:new)
		end
	end

	describe 'GET #edit' do
		before(:each) { get :edit, id: project }

		it 'assigns @project' do
			expect(assigns(:project)).to eq(project)
		end

		it 'renders the #edit template' do
			expect(response).to render_template(:edit)
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, project: attributes_for(:project) }

			it 'creates the project' do
				expect(Project.count).to eq(1)
			end

			it 'redirects to #show for the new project' do
				expect(response).to redirect_to(Project.first)
			end
		end

		context 'with invalid attributes' do
			before(:each) { post :create, project: attributes_for(:project, title: nil) }

			it 'does not create the project' do
				expect(Project.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			before(:each) { patch :update, id: project, project: attributes_for(:project, title: 'New Title') }
			
			it 'updates the project' do
				expect(project.reload.title).to eq('New Title')
			end

			it 'redirects to #show the updated project' do
				expect(response).to redirect_to(project)
			end
		end

		context 'with invalid attributes' do
			before(:each) { patch :update, id: project, project: attributes_for(:project, title: '') }

			it 'does not update the project' do
				expect(project.title).to eq(project.reload.title)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, id: project }

		it 'deletes the project' do
			expect(Project.count).to eq(0)
		end

		it 'redirects to projects_path' do
			expect(response).to redirect_to(projects_path)
		end
	end
end
