Rails.application.routes.draw do
  # get 'wikis/index'
  #
  # get 'wikis/show'
  #
  # get 'wikis/new'
  #
  # get 'wikis/edit'


  resources :wikis do
      resources :collaborators, only: [:create, :destroy, :index]
  end

  devise_for :users

  get 'user/downgrade'


  get 'welcome/about'

  root 'welcome#index'



  resources :charges, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
