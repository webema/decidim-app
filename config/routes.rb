Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin? } do # TODO: should be system admin only
    mount Sidekiq::Web => '/sidekiq'
  end

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :posts, controller: 'blog_posts', only: %i[index show], module: 'ema'

  resources :help_sections, only: :show, module: 'decidim'

  Decidim::Admin::Engine.routes.draw do
    resources :posts, controller: 'blog_posts'
    resources :newsletters, controller: 'email_exports'
  end
  get 'healthcheck' => 'healthcheck#index'
end
