# namespace :staging do
#   desc 'setup data for staging environment'
#   task setup: :environment do
#     raise 'You cannot run this in production' if Rails.env.production?
#     ActionMailer::Base.perform_deliveries = false

#     o = Decidim::Organization.first

#     o.colors = {
#       "alert": "#ec5840",
#       "theme": "#ef604d",
#       "primary": "#ffe900",
#       "success": "#57d685",
#       "warning": "#ffae00",
#       "highlight": "#be6400",
#       "secondary": "#551285",
#       "highlight-alternative": "#ff5731"
#     }

#     o.name = "Zukunftsprozess"

#     o.description = { "de": "<p>Et occaecati minus rem fugit porro enim aut nesciunt deleniti hic totam repellendus provident sunt.</p>" }

#     o.save

#     Decidim::ContentBlock.where(scope_name: 'homepage').delete_all

#     Decidim::ContentBlock.create(
#       organization: o, manifest_name: 'zukunftsprozess', scope_name: 'homepage', weight: 1, published_at: Time.now
#     )
#   end
# end



namespace :staging do
  desc 'setup data for staging environment'
  task setup: :environment do
    raise 'You cannot run this in production' if Rails.env.production?
    ActionMailer::Base.perform_deliveries = false

    truncate_tables
  end
end

def truncate_tables
  tables = ActiveRecord::Base.connection.tables
  tables.delete('schema_migrations')
  tables.each do |table|
    truncate_table(table)
  end
end


