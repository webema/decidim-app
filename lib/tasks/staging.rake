namespace :staging do
  desc 'truncate tables and seed'
  task reseed: :environment do
    raise 'You cannot run this in production' if Rails.env.production?

    truncate_tables
    Rake::Task['db:seed'].execute
  end
end

def truncate_tables
  tables = ActiveRecord::Base.connection.tables
  tables.delete('schema_migrations')
  tables.each do |table|
    truncate_table(table)
  end
end

private

def truncate_table(name)
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{name} RESTART IDENTITY CASCADE;")
end
