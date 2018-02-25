# Base controller
class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include Auth::ControllerHelpers

  protect_from_forgery

  def render_resource_not_found
    render status: 404, json: { error: 'Resource not found' }
  end

  def handle_unverified_request
    render status: 403
  end
end
