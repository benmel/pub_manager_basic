class TocSectionsController < ApplicationController
	before_action :authenticate_user!

	def new
		@book = find_book
		if TocSection.exists? book_id: @book
			redirect_to edit_book_toc_section_path
		else
			@toc_section = TocSection.new
			@toc_section.build_filled_liquid_template
		end
	end

	def edit
		@book = find_book
		@toc_section = @book.toc_section
		raise ActiveRecord::RecordNotFound unless @toc_section
	end

	def create
		@book = find_book
		@toc_section = @book.build_toc_section(toc_section_params)
		if @toc_section.save
			redirect_to @book
		else
			render :new
		end
	end

	def update
		@book = find_book
		@toc_section = @book.toc_section
		if @toc_section.update(toc_section_params)
			redirect_to @book
		else
			render :edit
		end
	end

	def destroy
		@book = find_book
		@book.toc_section.destroy
		redirect_to @book
	end

	private
	def find_book
		current_user.books.find(params[:book_id])
	end

	def toc_section_params
		params.require(:toc_section).permit(
			:content, 
			filled_liquid_template_attributes: [:id, :content, 
				filled_liquid_template_parameters_attributes: [:id, :name, :value, :_destroy]]
		)
	end
end
