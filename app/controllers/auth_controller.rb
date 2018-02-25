# This controller helps the user login and logout
class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /api/auth/login
  def login
    unless (token = params.dig(:google, :id_token))
      render status: 422
      return
    end

    result = Auth::GoogleLoginCommand.call(token: token)
    if result.success?
      sign_in(result.user)
      render status: 201, json: { user: result.user, token: form_authenticity_token }
    else
      render status: 401
    end
  end

  # DELETE /api/auth/logout
  def logout
    sign_out
  end
end
