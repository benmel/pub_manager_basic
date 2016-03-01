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

  def form
    @project = find_project
    if Book.exists? project_id: @project
      set_liquid_templates
      @book = @project.book
      render partial: 'form'
    else
      @book = Book.new
      unless params[:liquid_template_id].present?
        set_liquid_templates
        render partial: 'form'
      else  
        @liquid_template = find_liquid_template
        case @liquid_template.template_type
        when 'front_section'
          @book.build_front_section
          @book.set_front_section_content_and_section_parameters_from @liquid_template
          render partial: 'wrapper_front'
        when 'toc_section'
          @book.build_toc_section
          @book.set_toc_section_content_and_section_parameters_from @liquid_template
          render partial: 'wrapper_toc'
        when 'section'
          @book.sections.build
          @book.set_first_section_content_and_section_parameters_from @liquid_template
          @content_liquid_templates = find_liquid_templates(:section)
          render partial: 'wrapper_sections'
        else
          # need both a liquid_template_id and section_type to create form
          render text: 'Incorrect section_type', status: :bad_request
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

  def find_liquid_template
    current_user.liquid_templates.send(params[:section_type]).find(params[:liquid_template_id])
  end

  def find_liquid_templates(type)
    current_user.liquid_templates.send(type).order('LOWER(name)').all
  end

  def set_liquid_templates
    @front_liquid_templates = find_liquid_templates(:front_section)
    @toc_liquid_templates = find_liquid_templates(:toc_section)
    @content_liquid_templates = find_liquid_templates(:section)
  end

  def book_params
    params.require(:book).permit(
      front_section_attributes: [:id, :content, section_parameters_attributes: [:id, :name, :value]],
      toc_section_attributes: [:id, :content, section_parameters_attributes: [:id, :name, :value]],
      sections_attributes: [:id, :name, :content, section_parameters_attributes: [:id, :name, :value]])
  end
end
