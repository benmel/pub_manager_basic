class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = current_user.books
  end

  def show
    @book = find_book
  end

  def new
    @project = find_project
    if Book.exists? project_id: @project
      redirect_to @project.book
    else
      @book = Book.new
      @book.build_front_section
      @book.build_toc_section
      @book.sections.build
      @templates = find_templates
    end
  end

  def create
    @project = find_project
    @book = @project.build_book(book_params)
    if @book.save
      redirect_to @book
    else
      @templates = find_templates
      render :new
    end
  end

  def destroy
    @book = find_book
    @project = @book.project
    @book.destroy
    redirect_to @project
  end

  private
  def find_book
    current_user.books.find(params[:id])
  end

  def find_project
    current_user.projects.find(params[:project_id])
  end

  def find_templates
    current_user.templates.order('LOWER(name)').all
  end

  def book_params
    params.require(:book).permit(front_section_attributes: [:id, :content, section_parameters_attributes: [:id, :name, :value]],toc_section_attributes: [:id, :content, section_parameters_attributes: [:id, :name, :value]],sections_attributes: [:id, :name, :content, section_parameters_attributes: [:id, :name, :value]])
  end
end
