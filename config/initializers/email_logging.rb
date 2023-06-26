ActionMailer::Base.class_eval do
  include EmailLoggingAfterFilter
end
