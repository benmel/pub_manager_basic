class TemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @templates = find_templates
  end

  def show
    @template = find_template
  end

  def new
    @template = Template.new
  end

  def edit
    @template = find_template
  end

  def create
    @template = current_user.templates.build(template_params)
    if @template.save
      redirect_to @template
    else
      render :new
    end
  end

  def update
    @template = find_template
    if @template.update(template_params)
      redirect_to @template
    else
      render :edit
    end
  end

  def destroy
    @template = find_template
    @template.destroy
    redirect_to templates_path
  end

  private
  def find_template
    current_user.templates.find(params[:id])
  end

  def find_templates
    current_user.templates.order('LOWER(name)').all
  end

  def template_params
    params.require(:template).permit(:name, :content, template_parameters_attributes: [:id, :name, :_destroy])
  end
end
