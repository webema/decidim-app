# frozen_string_literal: true

module Decidim
  # A command with all the business logic when users are exported.
  class ExportUsers < Decidim::Command
    # Public: Initializes the command.
    #
    def initialize()
    end

    # Executes the command
    #
    # Returns csv-file.
    def call
      attributes = %w{id email name}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        users.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

    private

    def users
      Decidim::User.confirmed.where.not(newsletter_notifications_at: nil)
    end
  end
end
