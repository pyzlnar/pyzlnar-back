# This controller handles the project resource
class ProjectsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!, except: :index
  before_action :set_project, only: %i[update destroy]

  # GET /api/projects
  def index
    render json: Project.cached
  end

  # POST /api/projects
  def create
    @project = Project.new(project_params)
    if @project.save
      render status: 201, json: @project
    else
      render status: 422, json: { project: @project.errors }
    end
  end

  # PATCH /api/projects/:code
  def update
    if @project.update(project_params)
      render status: 200, json: @project
    else
      render status: 422, json: { project: @project.errors }
    end
  end

  # DELETE /api/projects/:code
  def destroy
    @project.destroy
    render status: 204
  end

  private

  def set_project
    @project = Project.find_by(code: params[:id])
    render_resource_not_found unless @project
  end

  def project_params
    params.fetch(:project, {}).permit(
      :code,
      :name,
      :status,
      :url,
      :start_date,
      :end_date,
      :short,
      :description,
      topics: []
    )
  end
end
