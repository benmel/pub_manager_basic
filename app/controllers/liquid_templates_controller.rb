class LiquidTemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @liquid_templates = find_liquid_templates
  end

  def show
    @liquid_template = find_liquid_template
    respond_to do |format|
      format.html
      format.json { render json: @liquid_template, include: :liquid_template_parameters }
    end
  end

  def new
    @liquid_template = LiquidTemplate.new
  end

  def edit
    @liquid_template = find_liquid_template
  end

  def create
    @liquid_template = current_user.liquid_templates.build(liquid_template_params)
    if @liquid_template.save
      redirect_to @liquid_template
    else
      render :new
    end
  end

  def update
    @liquid_template = find_liquid_template
    if @liquid_template.update(liquid_template_params)
      redirect_to @liquid_template
    else
      render :edit
    end
  end

  def destroy
    @liquid_template = find_liquid_template
    @liquid_template.destroy
    redirect_to liquid_templates_path
  end

  private
  def find_liquid_template
    current_user.liquid_templates.find(params[:id])
  end

  def find_liquid_templates
    current_user.liquid_templates.order('LOWER(name)').all
  end

  def liquid_template_params
    params.require(:liquid_template).permit(:name, :content, :category, liquid_template_parameters_attributes: [:id, :name, :_destroy])
  end
end
