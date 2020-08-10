Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      post 'login' => "sessions#create"
      resources :techs, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :links, only: [:index, :show, :create, :destroy]
    end
  end
  root 'homepage#index'
  get '/*path' => 'homepage#index'
end
