# frozen_string_literal: true

module Decidim
  module Admin
    class UserExportsController < Decidim::Admin::ApplicationController
      before_action :enforce_permission

      def index
        @count = Decidim::User.confirmed.where.not(newsletter_notifications_at: nil).count
      end

      def create
        send_data ExportUsers.new().call, filename: "decidim-users-#{Date.today}.csv"
      end

      private

      def enforce_permission
        enforce_permission_to :update, :organization
      end
    end
  end
end
