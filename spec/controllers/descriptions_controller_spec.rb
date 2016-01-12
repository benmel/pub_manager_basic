require 'rails_helper'

RSpec.describe DescriptionsController, type: :controller do
	before(:each) do
		@user ||= create(:user)
		sign_in @user
		@project ||= create(:project, user: @user)
	end

	let(:description) { create(:description, project: @project) }

	describe 'GET #show' do
		context 'description exists' do
			before(:each) { get :show, project_id: description.project }
			
			it 'assigns @description' do
				expect(assigns(:description)).to eq(description)
			end

			it 'renders the #show template' do
				expect(response).to render_template(:show)
			end
		end

		context 'description does not exist' do
			it 'raises an error' do
				expect { 
					get :show, project_id: @project 
				}.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'GET #new' do
		context 'description exists' do
			it 'redirects to edit_project_description_path' do
				get :new, project_id: description.project
				expect(response).to redirect_to(edit_project_description_path)
			end
		end
		
		context 'description does not exist' do
			before(:each) { get :new, project_id: @project }

			it 'assigns a new @description' do
				expect(assigns(:description)).to be_a_new(Description)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end

	end

	describe 'GET #edit' do
		context 'description exists' do
			before(:each) { get :edit, project_id: description.project }

			it 'assigns @description' do
				expect(assigns(:description)).to eq(description)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end

		context 'description does not exist' do
			it 'raises an error' do
				expect { 
					get :edit, project_id: @project 
				}.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, project_id: @project, description: attributes_for(:description) }

			it 'creates the description' do
				expect(Description.count).to eq(1)
			end

			it 'redirects to #show for the project' do
				expect(response).to redirect_to(@project)
			end
		end

		context 'with invalid attributes' do
			before(:each) { post :create, project_id: @project, description: attributes_for(:description, template: nil) }

			it 'does not create the description' do
				expect(Description.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			before(:each) { patch :update, project_id: description.project, description: attributes_for(:description, template: 'Template') }
			
			it 'updates the description' do
				expect(description.reload.template).to eq('Template')
			end

			it 'redirects to #show the updated project' do
				expect(response).to redirect_to(description.project)
			end
		end

		context 'with invalid attributes' do
			before(:each) { patch :update, project_id: description.project, description: attributes_for(:description, template: '') }

			it 'does not update the description' do
				expect(description.template).to eq(description.reload.template)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, project_id: description.project }

		it 'deletes the description' do
			expect(Description.count).to eq(0)
		end

		it 'redirects to #show for the project' do
			expect(response).to redirect_to(description.project)
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { 
				get :show, project_id: description.project 
			}.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
