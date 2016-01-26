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

  def form
    @project = find_project
    @templates = find_templates
    if Book.exists? project_id: @project
      @book = @project.book
      render partial: 'form'
    else
      @book = Book.new
      unless params[:template_id].present?
        render partial: 'form'
      else  
        @template = find_template
        case params[:section_type]
        when 'front_section'
          @book.build_front_section
          @book.set_front_section_content_and_section_parameters_from @template
          render partial: 'wrapper_front'
        when 'toc_section'
          @book.build_toc_section
          @book.set_toc_section_content_and_section_parameters_from @template
          render partial: 'wrapper_toc'
        when 'section'
          @book.sections.build
          @book.set_first_section_content_and_section_parameters_from @template
          render partial: 'wrapper_sections'
        else
          # need both a template_id and section_type to create form
          render text: 'Missing section_type', status: :bad_request
        end
      end
    end
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

  def find_template
    current_user.templates.find(params[:template_id])
  end

  def find_templates
    current_user.templates.order('LOWER(name)').all
  end

  def book_params
    params.require(:book).permit(
      front_section_attributes: [:id, :content, section_parameters_attributes: [:id, :name, :value]],
      toc_section_attributes: [:id, :content, section_parameters_attributes: [:id, :name, :value]],
      sections_attributes: [:id, :name, :content, section_parameters_attributes: [:id, :name, :value]])
  end
end
