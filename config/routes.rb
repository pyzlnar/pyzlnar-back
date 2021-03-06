Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    get :status, to: 'status#index'

    namespace :auth do
      post   :login
      delete :logout
    end

    resource  :me, controller: :me, only: %i[show update]
    resources :projects, except: :show
    resources :sites,    except: :show
  end
end
