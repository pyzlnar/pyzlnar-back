# This controller allows to retrieve or modify the already logged in user
class MeController < ApplicationController
  before_action :authenticate_user!

  # GET /api/me
  def show
    render json: current_user
  end

  # PATCH /api/me
  def update
    if current_user.update(user_params)
      render json: current_user
    else
      render status: 422, json: { user: current_user.errors }
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:username)
  end
end
