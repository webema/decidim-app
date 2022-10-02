Sentry.init do |config|
  config.dsn = 'https://dcdc76ed57444f40aacd8f380339b3b9@o97645.ingest.sentry.io/6781597'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  config.environment = 'production'
  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
