# Base controller
class ApplicationController < ActionController::API
  include Auth::ControllerHelpers

  def render_resource_not_found
    render status: 404, json: { error: 'Resource not found' }
  end
end
