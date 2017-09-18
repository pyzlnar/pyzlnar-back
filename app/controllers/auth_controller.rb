# This controller helps the user login and logout
class AuthController < ApplicationController
  # POST /api/auth/login
  def login
    unless (token = params.dig(:google, :id_token))
      render status: 422
      return
    end

    result = GoogleLoginCommand.call(token: token)
    if result.success?
    else
      render status: 401
    end
  end

  # POST /api/auth/logout
  def logout
  end
end
