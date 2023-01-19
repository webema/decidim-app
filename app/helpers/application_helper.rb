module ApplicationHelper
  def extended_navigation_bar(items, max_items: 5)
    return unless items.count > 1

    items.prepend({
      name: icon("chevron-left", aria_label: t(".all_#{current_participatory_space_key}_menu_item"), role: "img"),
      url: extended_navigation_bar_back_link_path
    })

    extra_items = items.slice((max_items + 1)..-1) || []
    active_item = items.find { |item| item[:active] }

    render partial: "decidim/shared/extended_navigation_bar", locals: { items: items, extra_items: extra_items, active_item: active_item, max_items: max_items  }
  end

  def current_participatory_space_key
    current_participatory_space.class.name.demodulize.underscore.pluralize
  end

  def extended_navigation_bar_back_link_path
    case current_participatory_space
    when Decidim::Idea
      decidim_ideas.ideas_path
    when Decidim::Assembly
      decidim_assemblies.assemblies_path
    when Decidim::ParticipatoryProcess
      decidim_participatory_processes.participatory_processes_path
    end
  end

  def banner_image_path(process)
    process.attached_uploader(:hero_image)&.variant_path(:large) || process.type.attached_uploader(:banner_image)&.path
  end
end
