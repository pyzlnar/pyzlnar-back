# This controller allows to retrieve or modify the already logged in user
class MeController < ApplicationController
  before_action :authenticate_user!

  # GET /api/me
  def show
    render json: current_user
  end
end
