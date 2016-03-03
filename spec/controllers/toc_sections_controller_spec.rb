require 'rails_helper'

RSpec.describe TocSectionsController, type: :controller do
	render_views

	before(:each) do
		@user ||= create(:user_with_books)
		sign_in @user
	end

	let(:toc_section_with_book) { create(:toc_section, book: @user.books.first) }
	let(:book_without_toc_section) { @user.books.second }

	describe 'GET #new' do
		context 'toc_section exists' do
			it 'redirects to edit_book_toc_section_path' do
				get :new, book_id: toc_section_with_book.book
				expect(response).to redirect_to(edit_book_toc_section_path)
			end
		end
		
		context 'toc_section does not exist' do
			before(:each) { get :new, book_id: book_without_toc_section }

			it 'assigns a new @toc_section' do
				expect(assigns(:toc_section)).to be_a_new(TocSection)
			end

			it 'builds a filled_liquid_template' do
				expect(assigns(:toc_section).filled_liquid_template).to_not be_nil
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'GET #edit' do
		context 'toc_section exists' do
			before(:each) { get :edit, book_id: toc_section_with_book.book }

			it 'assigns @toc_section' do
				expect(assigns(:toc_section)).to eq(toc_section_with_book)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end

		context 'toc_section does not exist' do
			it 'raises an error' do
				expect { get :edit, book_id: book_without_toc_section }.to raise_error(ActiveRecord::RecordNotFound) 
			end
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, book_id: book_without_toc_section, toc_section: attributes_for(:toc_section) }

			it 'creates the toc_section' do
				expect(TocSection.count).to eq(1)
			end

			it 'redirects to #show for the book' do
				expect(response).to redirect_to(book_without_toc_section)
			end
		end

		context 'with invalid attributes' do
			before(:each) { post :create, book_id: book_without_toc_section, toc_section: attributes_for(:toc_section, content: '') }

			it 'does not create the toc_section' do
				expect(TocSection.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			before(:each) do
				@toc_section = build(:toc_section)
				patch :update, book_id: toc_section_with_book.book, toc_section: @toc_section.attributes
			end
			
			it 'updates the toc_section' do
				expect(toc_section_with_book.reload.content).to eq(@toc_section.content)
			end

			it 'redirects to #show the updated book' do
				expect(response).to redirect_to(toc_section_with_book.book)
			end
		end

		context 'with invalid attributes' do
			before :each do
				@toc_section = build(:toc_section, content: '')
				patch :update, book_id: toc_section_with_book.book, toc_section: @toc_section.attributes
			end

			it 'does not update the toc_section' do
				expect(toc_section_with_book.reload.content).to_not eq(@toc_section.content)
			end

			it 'renders the #edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, book_id: toc_section_with_book.book }

		it 'deletes the toc_section' do
			expect(TocSection.count).to eq(0)
		end

		it 'redirects to #show for the book' do
			expect(response).to redirect_to(toc_section_with_book.book)
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { get :edit, book_id: toc_section_with_book.book }.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
