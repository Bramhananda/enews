Enews::Application.routes.draw do
root :to => "admin/home#index"
devise_for :users, :controllers => { :sessions => "admin/sessions", :registrations => "admin/registrations", :passwords => "admin/passwords" }
namespace :admin do
 root :to => "home#index"
  resources :categories

  resources :articles

  get 'tag/:tag', to: 'articles#tagged', as: :tag

  resources :users

end
end