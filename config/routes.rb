Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    get :status, to: 'status#index'

    resources :projects, only: :index
    resources :sites,    only: :index
  end
end
