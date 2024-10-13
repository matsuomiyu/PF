Rails.application.routes.draw do
  namespace :admin do
    get 'homes/top'
  end
root to: "public/homes#top"
# 顧客用
# URL /customers/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  resources :relationships, only: [:followers, :followings]
  resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update]
  resources :messages, only: [:new, :index, :show, :edit]
  resources :keywords, only: [:search]
  resources :groups, only: [:new, :index, :show, :edit]
  resources :comments, only: [:new, :index, :show, :edit]
  get '/users/mypage/:id', to: 'users#mypage', as: 'mypage'
  get 'users/:id' => 'users#show', as: 'user'
  get 'users/:id/edit' => 'users#edit', as: 'edit_user'
  patch 'users/:id', to: 'users#update'
  get '/guest_login', to: 'sessions#guest_login'
  get 'homes/about' => 'homes#about', as: 'about'
  delete '/users/leave', to: 'users#leave', as: :leave_user
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
