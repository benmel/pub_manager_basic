class CoversController < ApplicationController
	def show
		@project = Project.find(params[:project_id])
		@cover = @project.cover
		raise ActiveRecord::RecordNotFound unless @cover
	end

	def new
		@project = Project.find(params[:project_id])
		if Cover.exists? project_id: @project
			redirect_to edit_project_cover_path
		else
			@cover = Cover.new
		end
	end

	def edit
		@project = Project.find(params[:project_id])
		@cover = @project.cover
		raise ActiveRecord::RecordNotFound unless @cover
	end

	def create
		@project = Project.find(params[:project_id])
		@cover = @project.build_cover(cover_params)
		
		if @cover.save
			redirect_to @project
		else
			render :new
		end
	end

	def update
		@project = Project.find(params[:project_id])
		@cover = @project.cover

		if @cover.update(cover_params)
			redirect_to @project
		else
			render :edit
		end
	end

	def destroy
		@project = Project.find(params[:project_id])
		@project.cover.destroy
		redirect_to @project
	end

	private
	def cover_params
		params.require(:cover).permit(:photographer, :license)
	end
end
