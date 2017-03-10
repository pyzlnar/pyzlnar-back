# This controller handles the project resource
class ProjectsController < ApplicationController
  # GET /api/projects
  def index
    render json: Project.cached
  end
end
