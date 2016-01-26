class ProjectsController < ApplicationController
	before_action :authenticate_user!

	def index
		@projects = find_projects
	end

	def show
		@project = find_project
	end

	def new
		@project = Project.new
	end

	def edit
		@project = find_project
	end

	def create
		@project = current_user.projects.build(project_params)
		if @project.save
			redirect_to @project
		else
			render :new
		end
	end

	def update
		@project = find_project
		if @project.update(project_params)
			redirect_to @project
		else
			render :edit
		end
	end

	def destroy
		@project = find_project
		@project.destroy
		redirect_to projects_path
	end

	private 
	def find_project
		current_user.projects.find(params[:id])
	end

	def find_projects
		current_user.projects.order('LOWER(title)').all
	end

	def project_params
		params.require(:project).permit(:title, :subtitle, :author, :keywords, :description, :isbn10, :isbn13)
	end
end
