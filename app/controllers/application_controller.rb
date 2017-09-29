# Base controller
class ApplicationController < ActionController::API
  include Auth::ControllerHelpers
end
