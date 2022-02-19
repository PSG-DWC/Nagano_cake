Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#顧客

scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only: [:index, :show]
  resource :customers, only: [:show, :edit, :update] do
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
  end
  resources :addresses, only: [:index, :create, :destroy, :edit, :update]
  resources :cart_items, only: [:create, :index, :destroy, :update] do
    collection do
      delete 'destroy_all'
    end
  end

  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      get 'confirm'
      get 'complete'
    end
  end
end

#管理者
namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]
  resources :orders, only: [:index, :show, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :items, only: [:new, :create, :index, :show, :edit, :update]
  resources :orders_details, only: [:update]
end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
