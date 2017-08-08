Rails.application.routes.draw do
  root :to => 'admin/dashboard#index'
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match "mock/*url" => "application#run", via: [:get, :post, :put, :patch, :delete]
end
