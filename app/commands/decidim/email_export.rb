# frozen_string_literal: true

module Decidim
  # A command with all the business logic when users are exported.
  class EmailExport < Decidim::Command
    # Public: Initializes the command.
    #
    def initialize()
    end

    # Executes the command. Broadcasts these events:
    #
    # - :ok when everything is valid, together with the report.
    # - :invalid if the form wasn't valid and we couldn't proceed.
    #
    # Returns nothing.
    def call
      attributes = %w{id email first_name last_name}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        users.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

    private

    def users
      User.confirmed
    end
  end
end
