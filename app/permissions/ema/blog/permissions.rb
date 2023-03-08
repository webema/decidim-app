# frozen_string_literal: true

module Ema
  module Blog
    class Permissions < Decidim::DefaultPermissions
      def permissions
        permission_action
      end

      private

      def authorized?(permission_action, resource: nil, permissions_holder: nil)
        return unless resource || permissions_holder

        ActionAuthorizer.new(user, permission_action, permissions_holder, resource).authorize.ok?
      end
    end
  end
end
