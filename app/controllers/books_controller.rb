class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = find_books
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
      @book.build_empty_book
      set_liquid_templates
    end
  end

  def create
    @project = find_project
    @book = @project.build_book(book_params)
    if @book.save
      redirect_to @book
    else
      set_liquid_templates
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

  def find_books
    current_user.books.joins(:project).order('LOWER(projects.title)').all
  end

  def find_project
    current_user.projects.find(params[:project_id])
  end

  def find_liquid_templates(type)
    current_user.liquid_templates.with_category(type).order('LOWER(name)').all    
  end

  def set_liquid_templates
    @front_liquid_templates = find_liquid_templates(:front_section)
    @toc_liquid_templates = find_liquid_templates(:toc_section)
    @body_liquid_templates = find_liquid_templates(:body_section)
  end

  def book_params
    params.require(:book).permit(
      front_section_attributes: [:id, :content, 
        filled_liquid_template_attributes: [:id, :content, 
          filled_liquid_template_parameters_attributes: [:id, :name, :value]]],
      toc_section_attributes: [:id, :content, 
        filled_liquid_template_attributes: [:id, :content, 
          filled_liquid_template_parameters_attributes: [:id, :name, :value]]],
      body_sections_attributes: [:id, :content, :name,
        filled_liquid_template_attributes: [:id, :content, 
          filled_liquid_template_parameters_attributes: [:id, :name, :value]]])
  end
end
