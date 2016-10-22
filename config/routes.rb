require 'sidekiq/web'

Rails.application.routes.draw do
  
  devise_for :admins, :skip => [:registrations]

  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', :as => 'admin_registration'
  end

  authenticate :admin, lambda { |a| a.system_admin?} do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    root to: "home#index"
    resource :search, only: :show, controller: :search
    get '*path' => redirect('/admin')
  end

  root to: "home#index"
  resource :search, only: :show, controller: :search
  get '*path' => redirect('/')
end
