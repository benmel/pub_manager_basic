class CoversController < ApplicationController
	before_action :authenticate_user!

	def show
		@project = find_project
		@cover = @project.cover
		raise ActiveRecord::RecordNotFound unless @cover
	end

	def new
		@project = find_project
		if Cover.exists? project_id: @project
			redirect_to edit_project_cover_path
		else
			@cover = Cover.new
		end
	end

	def edit
		@project = find_project
		@cover = @project.cover
		raise ActiveRecord::RecordNotFound unless @cover
	end

	def create
		@project = find_project
		@cover = @project.build_cover(cover_params)
		if @cover.save
			redirect_to @project
		else
			render :new
		end
	end

	def update
		@project = find_project
		@cover = @project.cover
		if @cover.update(cover_params)
			redirect_to @project
		else
			render :edit
		end
	end

	def destroy
		@project = find_project
		@project.cover.destroy
		redirect_to @project
	end

	private
	def find_project
		Project.find(params[:project_id])
	end

	def cover_params
		params.require(:cover).permit(:photographer, :license)
	end
end
