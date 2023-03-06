Rails.application.routes.draw do
  if Rails.env.staging?
    mount Lockup::Engine, at: '/lockup'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require 'sidekiq/web'

  namespace :system do
    authenticate(:admin) do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  mount Ema::Blog::Engine => '/posts'

  Ema::Blog::Engine.routes.draw do
    resources :posts, path: '', controller: 'blog_posts', only: %i[index show], as: 'ema_blog_posts'
  end

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :help_sections, only: :show, module: 'decidim'

  Decidim::Admin::Engine.routes.draw do
    resource :survey
    resources :posts, controller: 'blog_posts'
    resources :newsletters, controller: 'user_exports', only: %i[index create]
  end
  get 'healthcheck' => 'healthcheck#index'
end
