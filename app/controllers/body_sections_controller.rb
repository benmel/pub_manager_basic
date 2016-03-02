class BodySectionsController < ApplicationController
	before_action :authenticate_user!

	def new
		@book = find_book
		@body_section = @book.body_sections.build
	end

	def edit
		@book = find_book
		@body_section = find_body_section
	end

	def create
		@book = find_book
		@body_section = @book.body_sections.build(body_section_params)
		if @body_section.save
			redirect_to @book
		else
			render :new
		end
	end

	def update
		@book = find_book
		@body_section = find_body_section
		if @body_section.update(body_section_params)
			respond_to do |format|
				format.html { redirect_to @book }
				format.json { render json: { 'Result': 'Body section updated successfully' }, status: :ok }
			end
		else
			respond_to do |format|
				format.html { render :edit }
				format.json { render json: { 'Result': 'Body section failed to update' }, status: :bad_request }
			end
		end
	end

	def destroy
		@book = find_book
		@body_section = find_body_section
		@body_section.destroy
		redirect_to @book
	end

	private
	def find_book
		current_user.books.find(params[:book_id])
	end

	def find_body_section
		current_user.books.find(params[:book_id]).body_sections.find(params[:id])
	end

	def body_section_params
		params.require(:body_section).permit(:name, :content, :row_order_position, section_parameters_attributes: [:id, :name, :value, :_destroy])
	end
end
