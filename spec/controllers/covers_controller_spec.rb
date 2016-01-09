require 'rails_helper'

RSpec.describe CoversController, type: :controller do
	before(:each) do
		@user ||= create(:user)
		sign_in @user
		@project ||= create(:project, user: @user)
	end

	let(:cover) { create(:cover, project: @project) }

	describe 'GET #show' do
		context 'cover exists' do
			before(:each) { get :show, project_id: cover.project }
			
			it 'assigns @cover' do
				expect(assigns(:cover)).to eq(cover)
			end

			it 'renders the #show template' do
				expect(response).to render_template(:show)
			end
		end

		context 'cover does not exist' do
			it 'raises an error' do
				expect { 
					get :show, project_id: @project 
				}.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'GET #new' do
		context 'cover exists' do
			it 'redirects to edit_project_cover_path' do
				get :new, project_id: cover.project
				expect(response).to redirect_to(edit_project_cover_path)
			end
		end
		
		context 'cover does not exist' do
			before(:each) { get :new, project_id: @project }

			it 'assigns a new @cover' do
				expect(assigns(:cover)).to be_a_new(Cover)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end

	end

	describe 'GET #edit' do
		context 'cover exists' do
			before(:each) { get :edit, project_id: cover.project }

			it 'assigns @cover' do
				expect(assigns(:cover)).to eq(cover)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end

		context 'cover does not exist' do
			it 'raises an error' do
				expect { 
					get :edit, project_id: @project 
				}.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, project_id: @project, cover: attributes_for(:cover) }

			it 'creates the cover' do
				expect(Cover.count).to eq(1)
			end

			it 'redirects to #show for the project' do
				expect(response).to redirect_to(@project)
			end
		end

		context 'with invalid attributes' do
			before(:each) { post :create, project_id: @project, cover: attributes_for(:cover, photographer: nil) }

			it 'does not create the cover' do
				expect(Cover.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			before(:each) { patch :update, project_id: cover.project, cover: attributes_for(:cover, photographer: 'James Smith') }
			
			it 'updates the cover' do
				expect(cover.reload.photographer).to eq('James Smith')
			end

			it 'redirects to #show the updated project' do
				expect(response).to redirect_to(cover.project)
			end
		end

		context 'with invalid attributes' do
			before(:each) { patch :update, project_id: cover.project, cover: attributes_for(:cover, photographer: '') }

			it 'does not update the cover' do
				expect(cover.photographer).to eq(cover.reload.photographer)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, project_id: cover.project }

		it 'deletes the cover' do
			expect(Cover.count).to eq(0)
		end

		it 'redirects to #show for the project' do
			expect(response).to redirect_to(cover.project)
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { 
				get :show, project_id: cover.project 
			}.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
