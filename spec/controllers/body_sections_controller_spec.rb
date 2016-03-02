require 'rails_helper'

RSpec.describe BodySectionsController, type: :controller do
	render_views

	before(:each) do
		@user ||= create(:user_with_books)
		sign_in @user
	end

	let(:body_section_with_book) { create(:body_section, book: @user.books.first) }
	let(:book_without_body_section) { @user.books.second }

	describe 'GET #new' do
		before(:each) { get :new, book_id: book_without_body_section }

		it 'assigns @book' do
			expect(assigns(:book)).to eq(book_without_body_section)
		end

		it 'assigns a new @body_section' do
			expect(assigns(:body_section)).to be_a_new(BodySection)
		end

		it 'renders the #new template' do
			expect(response).to render_template(:new)
		end
	end

	describe 'GET #edit' do
		before(:each) { get :edit, book_id: body_section_with_book.book, id: body_section_with_book }

		it 'assigns @book' do
			expect(assigns(:book)).to eq(body_section_with_book.book)
		end

		it 'assigns @body_section' do
			expect(assigns(:body_section)).to eq(body_section_with_book)
		end

		it 'renders the #edit template' do
			expect(response).to render_template(:edit)
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			before(:each) { post :create, book_id: book_without_body_section, body_section: attributes_for(:body_section) }

			it 'creates the body section' do
				expect(BodySection.count).to eq(1)
			end

			it 'redirects to #show for the book' do
				expect(response).to redirect_to(book_without_body_section)
			end
		end

		context 'with invalid attributes' do
			before(:each) { post :create, book_id: book_without_body_section, body_section: attributes_for(:body_section, content: '') }

			it 'does not create the body section' do
				expect(BodySection.count).to eq(0)
			end

			it 'renders the #new template' do
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			let(:body_section) { build(:body_section) }
			
			context 'html format' do
				before(:each) { patch :update, book_id: body_section_with_book.book, id: body_section_with_book, body_section: body_section.attributes }

				it 'updates the body section' do
					expect(body_section_with_book.reload.content).to eq(body_section.content)
				end

				it 'redirects to #show the updated book' do
					expect(response).to redirect_to(body_section_with_book.book)
				end
			end

			context 'json format' do
				it 'returns ok status' do
					patch :update, book_id: body_section_with_book.book, id: body_section_with_book, body_section: body_section.attributes, format: :json
					expect(response).to have_http_status(:ok)
				end
			end
		end

		context 'with invalid attributes' do
			let(:body_section) { build(:body_section, content: '') }

			context 'html format' do
				before(:each) { patch :update, book_id: body_section_with_book.book, id: body_section_with_book, body_section: body_section.attributes }

				it 'does not update the body section' do
					expect(body_section_with_book.reload.content).to_not eq(body_section.content)
				end

				it 'renders the #edit template' do
					expect(response).to render_template(:edit)
				end
			end

			context 'json format' do
				it 'returns bad_request status' do
					patch :update, book_id: body_section_with_book.book, id: body_section_with_book, body_section: body_section.attributes, format: :json
					expect(response).to have_http_status(:bad_request)
				end
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) { delete :destroy, book_id: body_section_with_book.book, id: body_section_with_book }

		it 'deletes the body section' do
			expect(BodySection.count).to eq(0)
		end

		it 'redirects to #show for the book' do
			expect(response).to redirect_to(body_section_with_book.book)
		end
	end

	describe 'different user' do
		it 'raises an error' do
			sign_in create(:user)
			expect { get :edit, book_id: body_section_with_book.book, id: body_section_with_book }.to raise_error(ActiveRecord::RecordNotFound) 
		end
	end
end
