Decidim.menu :admin_menu do |menu|
  menu.item I18n.t('menu.blog_posts', scope: 'decidim.ema'),
            '/admin/news',
            icon_name: 'pencil',
            position: 7.2,
            active: :inclusive,
            if: true
end
