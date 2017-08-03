Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match "api/*url" => "application#run", via: [:get, :post, :put, :patch, :delete]
end
