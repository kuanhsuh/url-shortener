Rails.application.routes.draw do
  resources :links, only: [:new, :create]
  root "links#new"
  get "/links/:slug", to: 'links#show', as: :link
  get "/temp/:slug", to: 'links#temp', as: :temp

end
