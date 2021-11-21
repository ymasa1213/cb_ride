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

  # ユーザー
  scope module: :user do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:show, :edit, :update] do
      get "unsubscribe" => "users#unsubscribe"
      patch "withdraw" => "users#withdraw"
    end
    resources :posts do
      resource :likes, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
    end

    resources :users do
      resource :relationships, only:[:create, :destroy]
      get :followings, on: :member
      get :followers, on: :member
    end
    get  'index' =>'messages#index'
    post 'confirm' => 'messages#confirm'
    post 'back', to: 'messages#back'
    post 'done' => 'messages#done'

    get 'search' => 'posts#search'
  end

  # 管理者
  namespace :admin do
    root to:"homes#top"
    resources :users, only:[:index, :show, :edit, :update]
    resources :posts do
    resources :comments, only:[:destroy]
    end
  end

end