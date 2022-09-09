# frozen_string_literal: true

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

source 'https://nexus.devops-e.de/repository/rubygems'

ruby RUBY_VERSION

DECIDIM_VERSION = { github: 'decidim/decidim', branch: 'chore/l10n/release/0.27-stable' }.freeze

gem 'decidim', DECIDIM_VERSION
# gem 'decidim-initiatives', DECIDIM_VERSION

# gem 'decidim-ideas', path: '../decidim-ideas'

# gem "decidim-decidim_awesome"

gem 'bootsnap', '~> 1.3'

gem 'puma', '>= 5.0.0'

gem 'faker', '~> 2.14'

gem 'wicked_pdf', '~> 2.1'

gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'haml'
# Hack?
gem 'rexml', '~> 3.2.5'

# Password protect staging environment
gem 'rack_password'

group :development, :test do
  gem 'byebug', '~> 11.0', platform: :mri
  gem 'brakeman'
  gem 'decidim-dev', DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 4.2"
end

group :production, :staging do
  gem 'aws-sdk-s3', require: false
end

group :staging do
  # avoid emailing your users from non-production environments [https://github.com/croaky/recipient_interceptor]
  gem 'recipient_interceptor'
end
