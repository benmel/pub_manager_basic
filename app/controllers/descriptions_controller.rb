class DescriptionsController < ApplicationController
	before_action :authenticate_user!

	def show
		@project = find_project
		@description = @project.description
		raise ActiveRecord::RecordNotFound unless @description
	end

	def new
		@project = find_project
		if Description.exists? project_id: @project
			redirect_to edit_project_description_path
		else
			@description = Description.new
			@liquid_templates = find_liquid_templates
		end
	end

	def edit
		@project = find_project
		@description = @project.description
		raise ActiveRecord::RecordNotFound unless @description
	end

	def create
		@project = find_project
		@description = @project.build_description(description_params)
		if @description.save
			redirect_to @project
		else
			@liquid_templates = find_liquid_templates
			render :new
		end
	end

	def update
		@project = find_project
		@description = @project.description
		if @description.update(description_params)
			redirect_to @project
		else
			render :edit
		end
	end

	def destroy
		@project = find_project
		@project.description.destroy
		redirect_to @project
	end

	def preview
		@project = find_project
		@description = @project.description
		raise ActiveRecord::RecordNotFound unless @description
		@kindle = @description.kindle
		@createspace = @description.createspace
		@acx = @description.acx
	end

	def form
		@project = find_project
		if Description.exists? project_id: @project
			@description = @project.description
		else
			@description = Description.new
			# only render form with filled in template if liquid_template_id is present
			if params[:liquid_template_id].present?
				liquid_template = find_liquid_template
				@description.set_template_and_description_parameters_from liquid_template
			end
		end
		render partial: 'form'
	end

	private
	def find_project
		current_user.projects.find(params[:project_id])
	end

	def find_liquid_template
		current_user.liquid_templates.description.find(params[:liquid_template_id])
	end

	def find_liquid_templates
		current_user.liquid_templates.description.order('LOWER(name)').all
	end

	def description_params
		params.require(:description).permit(:template, :content, :chapter_list, :excerpt, description_parameters_attributes: [:id, :name, :value, :_destroy])
	end
end
