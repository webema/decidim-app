Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :news, controller: 'blog_posts', only: %i[index show], module: 'ema'

  Decidim::Admin::Engine.routes.draw do
    resources :news, controller: 'blog_posts', as: 'blog_posts'
  end
end
