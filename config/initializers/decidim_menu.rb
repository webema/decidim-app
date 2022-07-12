Decidim.menu :admin_menu do |menu|
  menu.item I18n.t('admin_menu.blog_posts', scope: 'decidim.ema'),
            '/admin/news',
            icon_name: 'pencil',
            position: 7.2,
            active: :inclusive,
            if: true
end

Decidim.menu :menu do |menu|
  menu.item I18n.t('menu.blog_posts', scope: 'decidim.ema'),
            '/news',
            position: 5,
            active: :inclusive
end
