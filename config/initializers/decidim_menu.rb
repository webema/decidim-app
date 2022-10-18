Decidim.menu :admin_menu do |menu|
  menu.item I18n.t('admin_menu.blog_posts', scope: 'decidim.ema'),
            '/admin/posts',
            icon_name: 'pencil',
            position: 7.2,
            active: :inclusive,
            if: allowed_to?(:update, :organization, organization: current_organization)

  menu.remove_item :newsletters
  menu.item I18n.t('admin_menu.newsletters', scope: 'decidim.ema'),
            '/admin/newsletters',
            icon_name: 'envelope-closed',
            position: 7.2,
            active: :inclusive,
            if: allowed_to?(:update, :organization, organization: current_organization)
end

Decidim.menu :menu do |menu|
  menu.item I18n.t('menu.blog_posts', scope: 'decidim.ema'),
            '/posts',
            position: 5,
            active: :inclusive
  menu.move :assemblies, after: :ideas
  menu.move :participatory_processes, after: :assemblies
end
