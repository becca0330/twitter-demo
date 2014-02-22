TwitterStart::Application.routes.draw do
  root to: 'root#home'
  devise_for :users
  resources :posts
  resources :users do
    post 'follow', on: :member
    delete 'unfollow', on: :member
  end

end
