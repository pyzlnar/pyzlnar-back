Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    get :status, to: 'status#index'
  end
end
