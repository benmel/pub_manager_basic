require 'rails_helper'

RSpec.describe FrontSectionsController, type: :controller do
	render_views

	before(:each) do
		@user ||= create(:user_with_books)
		sign_in @user
	end

	let(:front_section_with_book) { create(:front_section, book: @user.books.first) }
	let(:book_without_front_section) { @user.books.second }

	describe 'GET #new' do
		context 'front_section exists' do
			it 'redirects to edit_book_front_section_path' do
				get :new, book_id: front_section_with_book.book
				expect(response).to redirect_to(edit_book_front_section_path)
			end
		end
		
		context 'front_section does not exist' do
			before(:each) { get :new, book_id: book_without_front_section }

			it 'assigns a new @front_section' do
				expect(assigns(:front_section)).to be_a_new(FrontSection)
			end

			it 'builds a filled_liquid_template' do
				expect(assigns(:front_section).filled_liquid_template).to_not be_nil
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'GET #edit' do
		context 'front_section exists' do
			before(:each) { get :edit, book_id: front_section_with_book.book }

			it 'assigns @front_section' do
				expect(assigns(:front_section)).to eq(front_section_with_book)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end

		context 'front_section does not exist' do
			it 'raises an error' do
				expect { get :edit, book_id: book_without_front_section }.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, book_id: book_without_front_section, front_section: attributes_for(:front_section) }

			it 'creates the front_section' do
				expect(FrontSection.count).to eq(1)
			end

			it 'redirects to #show for the book' do
				expect(response).to redirect_to(book_without_front_section)
			end
		end

		context 'with invalid attributes' do
			before(:each) do
				front_section = build(:front_section)
				filled_liquid_template = build(:filled_liquid_template, :invalid_content)
				front_section_attributes = front_section.attributes.merge(filled_liquid_template_attributes: filled_liquid_template.attributes)
				post :create, book_id: book_without_front_section, front_section: front_section_attributes
			end

			it 'does not create the front_section' do
				expect(FrontSection.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			before(:each) do
				@front_section = build(:front_section)
				patch :update, book_id: front_section_with_book.book, front_section: @front_section.attributes
			end
			
			it 'updates the front_section' do
				expect(front_section_with_book.reload.content).to eq(@front_section.content)
			end

			it 'redirects to #show the updated book' do
				expect(response).to redirect_to(front_section_with_book.book)
			end
		end

		context 'with invalid attributes' do
			before :each do
				front_section = build(:front_section)
				filled_liquid_template = build(:filled_liquid_template, :invalid_content)
				front_section_attributes = front_section.attributes.merge(filled_liquid_template_attributes: filled_liquid_template.attributes)
				patch :update, book_id: front_section_with_book.book, front_section: front_section_attributes
			end

			it 'does not update the front_section' do
				expect(front_section_with_book.reload.filled_liquid_template).to be_nil
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, book_id: front_section_with_book.book }

		it 'deletes the front_section' do
			expect(FrontSection.count).to eq(0)
		end

		it 'redirects to #show for the book' do
			expect(response).to redirect_to(front_section_with_book.book)
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { get :edit, book_id: front_section_with_book.book }.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
