require 'rails_helper'

RSpec.describe DescriptionsController, type: :controller do
	render_views

	before(:each) do
		@user ||= create(:user_with_projects)
		sign_in @user
	end

	let(:description_with_project) { create(:description_with_valid_template, project: @user.projects.first) }
	let(:project_without_description) { @user.projects.second }

	describe 'GET #show' do
		context 'description exists' do
			before(:each) { get :show, project_id: description_with_project.project }
			
			it 'assigns @project' do
				expect(assigns(:project)).to eq(description_with_project.project)
			end

			it 'assigns @description' do
				expect(assigns(:description)).to eq(description_with_project)
			end

			it 'renders the #show template' do
				expect(response).to render_template(:show)
			end
		end

		context 'description does not exist' do
			it 'raises an error' do
				expect { 
					get :show, project_id: project_without_description 
				}.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'GET #new' do
		context 'description exists' do
			it 'redirects to edit_project_description_path' do
				get :new, project_id: description_with_project.project
				expect(response).to redirect_to(edit_project_description_path)
			end
		end
		
		context 'description does not exist' do
			before(:each) do
				@liquid_template = create(:liquid_template, category: :description, user: @user)
				get :new, project_id: project_without_description
			end

			it 'assigns a new @description' do
				expect(assigns(:description)).to be_a_new(Description)
			end

			it 'builds a filled_liquid_template' do
				expect(assigns(:description).filled_liquid_template).to_not be_nil
			end

			it 'assigns @liquid_templates' do
				expect(assigns(:liquid_templates)).to eq([@liquid_template])
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'GET #edit' do
		context 'description exists' do
			before(:each) { get :edit, project_id: description_with_project.project }

			it 'assigns @description' do
				expect(assigns(:description)).to eq(description_with_project)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end

		context 'description does not exist' do
			it 'raises an error' do
				expect { get :edit, project_id: project_without_description }.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, project_id: project_without_description, description: attributes_for(:description) }

			it 'creates the description' do
				expect(Description.count).to eq(1)
			end

			it 'redirects to #show for the project' do
				expect(response).to redirect_to(project_without_description)
			end
		end

		context 'with invalid attributes' do
			before :each do
				@liquid_template = create(:liquid_template, category: :description, user: @user)
				post :create, project_id: project_without_description, description: attributes_for(:description, content: '')
			end

			it 'does not create the description' do
				expect(Description.count).to eq(0)
			end

			it 'assigns @liquid_templates' do
				expect(assigns(:liquid_templates)).to eq([@liquid_template])
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			before(:each) do
				description_with_project.filled_liquid_template.content = 'different'
				description_attributes = description_with_project.attributes.merge(
					'filled_liquid_template_attributes' => description_with_project.filled_liquid_template.attributes)
				patch :update, project_id: description_with_project.project, description: description_attributes
			end
			
			it 'updates the description' do
				expect(description_with_project.reload.filled_liquid_template.content).to eq('different')
			end

			it 'redirects to #show the updated project' do
				expect(response).to redirect_to(description_with_project.project)
			end
		end

		context 'with invalid attributes' do
			before :each do
				@description = build(:description, content: '')
				patch :update, project_id: description_with_project.project, description: @description.attributes
			end

			it 'does not update the description' do
				expect(description_with_project.reload.content).to_not eq(@description.content)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, project_id: description_with_project.project }

		it 'deletes the description' do
			expect(Description.count).to eq(0)
		end

		it 'redirects to #show for the project' do
			expect(response).to redirect_to(description_with_project.project)
		end
	end

	describe 'GET #preview' do
		context 'description exists' do
			before(:each) { get :preview, project_id: description_with_project.project }
			
			it 'assigns @project' do
				expect(assigns(:project)).to eq(description_with_project.project)
			end

			it 'assigns @description' do
				expect(assigns(:description)).to eq(description_with_project)
			end

			it 'assigns @kindle' do
				expect(assigns(:kindle)).to_not be_nil
			end

			it 'assigns @createspace' do
				expect(assigns(:createspace)).to_not be_nil
			end

			it 'assigns @acx' do
				expect(assigns(:acx)).to_not be_nil
			end

			it 'renders the #preview template' do
				expect(response).to render_template(:preview)
			end
		end

		context 'description does not exist' do
			it 'raises an error' do
				expect { get :preview, project_id: project_without_description }.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { get :show, project_id: description_with_project.project }.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
