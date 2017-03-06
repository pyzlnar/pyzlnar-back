# This controller handles the site resource
class SitesController < ApplicationController
  # GET /api/sites
  def index
    render json: Site.cached
  end
end
