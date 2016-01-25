class FrontSectionsController < ApplicationController
	before_action :authenticate_user!

	def new
		@book = find_book
		if FrontSection.exists? book_id: @book
			redirect_to edit_book_front_section_path
		else
			@front_section = FrontSection.new
		end
	end

	def edit
		@book = find_book
		@front_section = @book.front_section
		raise ActiveRecord::RecordNotFound unless @front_section
	end

	def create
		@book = find_book
		@front_section = @book.build_front_section(front_section_params)
		if @front_section.save
			redirect_to @book
		else
			render :new
		end
	end

	def update
		@book = find_book
		@front_section = @book.front_section
		if @front_section.update(front_section_params)
			redirect_to @book
		else
			render :edit
		end
	end

	def destroy
		@book = find_book
		@book.front_section.destroy
		redirect_to @book
	end

	private
	def find_book
		current_user.books.find(params[:book_id])
	end

	def front_section_params
		params.require(:front_section).permit(:content, section_parameters_attributes: [:id, :name, :value, :_destroy])
	end
end
