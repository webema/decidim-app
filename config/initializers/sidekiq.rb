require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-scheduler'
require 'sidekiq-scheduler/web'
require 'config_parser'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    SidekiqScheduler::Scheduler.instance.rufus_scheduler_options = { max_work_threads: 1 }
    Sidekiq.schedule = ConfigParser.parse(File.join(Rails.root, 'config/sidekiq_scheduler.yml'), Rails.env)
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end

  config.redis = { url: "redis://#{ENV['REDIS_URL']}:6379/5" } # TODO: set correct namespace
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_URL']}:6379/5" }# TODO: set correct namespace
end
