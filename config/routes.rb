Rails.application.routes.draw do
  root 'homepages#index'

  get "search" => "homepages#search", as: "search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
