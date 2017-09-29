# This controller helps the user login and logout
class AuthController < ApplicationController
  # POST /api/auth/login
  def login
    unless (token = params.dig(:google, :id_token))
      render status: 422
      return
    end

    result = Auth::GoogleLoginCommand.call(token: token)
    if result.success?
      sign_in(result.user)
      render status: 201, json: result.user
    else
      render status: 401
    end
  end

  # DELETE /api/auth/logout
  def logout
    sign_out
  end
end
