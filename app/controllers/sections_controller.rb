class SectionsController < ApplicationController
	before_action :authenticate_user!

	def new
		@book = find_book
		@section = @book.sections.build
	end

	def edit
		@book = find_book
		@section = find_section
	end

	def create
		@book = find_book
		@section = @book.sections.build(section_params)
		if @section.save
			redirect_to @book
		else
			render :new
		end
	end

	def update
		@book = find_book
		@section = find_section
		if @section.update(section_params)
			redirect_to @book
		else
			render :edit
		end
	end

	def destroy
		@book = find_book
		@section = find_section
		@section.destroy
		redirect_to @book
	end

	private
	def find_book
		current_user.books.find(params[:book_id])
	end

	def find_section
		current_user.books.find(params[:book_id]).sections.find(params[:id])
	end

	def section_params
		params.require(:section).permit(:name, :content, section_parameters_attributes: [:id, :name, :value, :_destroy])
	end
end
