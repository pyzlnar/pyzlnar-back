# This controller handles the site resource
class SitesController < ApplicationController
  before_action :authenticate_user!, :authorize_user!, except: :index
  before_action :set_site, only: %i[update destroy]
  after_action :refresh_cache, only: %i[create update destroy]

  # GET /api/sites
  def index
    render json: Site.cached
  end

  # POST /api/sites
  def create
    @site = Site.new(site_params)
    if @site.save
      render status: 201, json: @site
    else
      render status: 422, json: { site: @site.errors }
    end
  end

  # PATCH /api/sites/:code
  def update
    if @site.update(site_params)
      render status: 200, json: @site
    else
      render status: 422, json: { site: @site.errors }
    end
  end

  # DELETE /api/sites/:code
  def destroy
    @site.destroy
    render status: 204
  end

  private

  def set_site
    @site = Site.find_by(code: params[:id])
    render_resource_not_found unless @site
  end

  def site_params
    params.fetch(:site, {}).permit(
      :code,
      :name,
      :status,
      :url,
      :description,
      topics: []
    )
  end

  def refresh_cache
    Site.cached(refresh: true) if response.status.in? 200...300
  end
end
