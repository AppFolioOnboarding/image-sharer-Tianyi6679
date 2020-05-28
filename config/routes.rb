Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  resources :images
  post '/images/send_email/:id', to: 'images#send_email', as: :image_send_email
  get '/images/share/:id', to: 'images#share', as: :image_share

  root 'welcome#index'
end
