Rails.application.routes.draw do
  root   'static_pages#home'
  get    'sessions/new'
  get    '/about',      to: 'static_pages#about'
  get    '/blog',       to: 'static_pages#blog'
  get    '/post/:id',   to: 'static_pages#post', as: 'post'
  get    '/signup',     to: 'users#new'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'
  get    '/recent_blog', to: 'blog_posts#recent_blog'
  resources :users
  resources :blog_posts
  resources :tags
end
