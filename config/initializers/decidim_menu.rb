Decidim.menu :admin_menu do |menu|
  menu.item I18n.t('admin_menu.blog_posts', scope: 'decidim.ema'),
            '/admin/posts',
            icon_name: 'pencil',
            position: 7.2,
            active: :inclusive,
            if: true
end

Decidim.menu :menu do |menu|
  menu.item I18n.t('menu.blog_posts', scope: 'decidim.ema'),
            '/posts',
            position: 5,
            active: :inclusive
  menu.move :assemblies, after: :initiatives
  menu.move :participatory_processes, after: :assemblies
end
