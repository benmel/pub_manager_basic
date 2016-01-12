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

	private
	def find_project
		current_user.projects.find(params[:project_id])
	end

	def description_params
		params.require(:description).permit(:template, :content, :chapter_list, :excerpt, filled_parameters_attributes: [:id, :name, :value, :_destroy])
	end
end
