Enews::Application.routes.draw do

root :to => "admin/home#index"
devise_for :users, :controllers => { :sessions => "admin/sessions", :registrations => "admin/registrations", :passwords => "admin/passwords" }
namespace :admin do
 root :to => "home#index"
 resources :galleries 
  resources :categories
  resources :pictures 
  get 'add_picture/:gallery_id', to: "pictures#new", as: "picture_add_to_gallery"
  post 'select_gallery/:id/:picture_id', to: "pictures#select_gallery_for_picture", as: "select_gallery_for_picture"
  post 'remove_gallery/:id/:picture_id', to: "pictures#remove_gallery_for_picture", as: "remove_gallery_for_picture"
  post 'show_galleries/:id', to: 'pictures#selectable_galleries', as: 'selectable_galleries'
  resources :articles

  get 'tag/:tag', to: 'articles#tagged', as: :tag

  resources :users

end
end