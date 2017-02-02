# This controller is just used as a quick way to know if the api is live or not.
class StatusController < ApplicationController
  # GET /api/status
  def index
    head :no_content
  end
end
