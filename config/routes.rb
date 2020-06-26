Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  resources :images do
    post 'send_email', on: :member
  end

  root 'welcome#index'
end
