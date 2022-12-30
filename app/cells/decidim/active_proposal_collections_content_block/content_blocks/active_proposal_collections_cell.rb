# frozen_string_literal: true

module Decidim
  module ActiveProposalCollectionsContentBlock
    module ContentBlocks
      class ActiveProposalCollectionsCell < Decidim::ViewModel
        include Decidim::ApplicationHelper # html_truncate
        # include Decidim::LayoutHelper # If icons are needed in the (customized) view
        include Decidim::SanitizeHelper # decidim_sanitize

        delegate :current_organization, to: :controller
        delegate :current_user, to: :controller

        def show
          render
        end

        def active_proposals_components
          @active_proposals_components ||= Decidim::Component.where(participatory_space_id: public_assemblies_ids, participatory_space_type: 'Decidim::Assembly' ).where( manifest_name: 'proposals' ).where.not( published_at: nil )
        end

        private

        def public_assemblies_ids
          Decidim::Assemblies::OrganizationPublishedAssemblies.new(current_organization).pluck(:id)
        end

      end
    end
  end
end
