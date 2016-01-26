require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
	render_views

	before(:each) do
		@user ||= create(:user_with_books)
		sign_in @user
	end

	let(:section_with_book) { create(:section, book: @user.books.first) }
	let(:book_without_section) { @user.books.second }

	describe 'GET #new' do
		before(:each) { get :new, book_id: book_without_section }

		it 'assigns @book' do
			expect(assigns(:book)).to eq(book_without_section)
		end

		it 'assigns a new @section' do
			expect(assigns(:section)).to be_a_new(Section)
		end

		it 'renders the #new template' do
			expect(response).to render_template(:new)
		end
	end

	describe 'GET #edit' do
		before(:each) { get :edit, book_id: section_with_book.book, id: section_with_book }

		it 'assigns @book' do
			expect(assigns(:book)).to eq(section_with_book.book)
		end

		it 'assigns @section' do
			expect(assigns(:section)).to eq(section_with_book)
		end

		it 'renders the #edit template' do
			expect(response).to render_template(:edit)
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, book_id: book_without_section, section: attributes_for(:section) }

			it 'creates the section' do
				expect(Section.count).to eq(1)
			end

			it 'redirects to #show for the book' do
				expect(response).to redirect_to(book_without_section)
			end
		end

		context 'with invalid attributes' do
			before(:each) { post :create, book_id: book_without_section, section: attributes_for(:section, content: '') }

			it 'does not create the section' do
				expect(Section.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			let(:section) { build(:section) }
			
			context 'html format' do
				before(:each) { patch :update, book_id: section_with_book.book, id: section_with_book, section: section.attributes }

				it 'updates the section' do
					expect(section_with_book.reload.content).to eq(section.content)
				end

				it 'redirects to #show the updated book' do
					expect(response).to redirect_to(section_with_book.book)
				end
			end

			context 'json format' do
				it 'returns ok status' do
					patch :update, book_id: section_with_book.book, id: section_with_book, section: section.attributes, format: :json
					expect(response).to have_http_status(:ok)
				end
			end
		end

		context 'with invalid attributes' do
			let(:section) { build(:section, content: '') }

			context 'html format' do
				before(:each) { patch :update, book_id: section_with_book.book, id: section_with_book, section: section.attributes }

				it 'does not update the section' do
					expect(section_with_book.reload.content).to_not eq(section.content)
				end

				it 'renders the #edit template' do
					expect(response).to render_template(:edit)
				end
			end

			context 'json format' do
				it 'returns bad_request status' do
					patch :update, book_id: section_with_book.book, id: section_with_book, section: section.attributes, format: :json
					expect(response).to have_http_status(:bad_request)
				end
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, book_id: section_with_book.book, id: section_with_book }

		it 'deletes the section' do
			expect(Section.count).to eq(0)
		end

		it 'redirects to #show for the book' do
			expect(response).to redirect_to(section_with_book.book)
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { get :edit, book_id: section_with_book.book, id: section_with_book }.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
