Rails.application.routes.draw do
# 会員
devise_for :users,skip: [:passwords,], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :user do
  root to: "homes#top"
  get "about" => "homes#about"

  resources :users, only: [:show, :edit, :update]
  resources :posts
  resources :likes, only:[:create, :destroy]
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"
  resources :users do
    resource :relationships, only:[:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
end

namespace :admin do
  root to:"homes#top"
  resources :users, only:[:index, :show, :edit, :update]
end

end


