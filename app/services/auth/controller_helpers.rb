# Auth helpers for controller
module Auth::ControllerHelpers
  attr_accessor :current_user

  def authenticate_user
    @current_user = User.find_by(uuid: session[:sub]) if session[:sub]
  end

  def authenticate_user!
    authenticate_user
    render status: 401 unless user_signed_in?
  end

  def authorize_user
    current_user&.admin?
  end

  def authorize_user!
    render status: 403 unless authorize_user
  end

  def sign_in(user)
    session[:sub] = user.uuid
    @current_user = user
  end

  def sign_out
    session.delete(:sub)
    @current_user = nil
  end

  def user_signed_in?
    current_user.present?
  end
end
