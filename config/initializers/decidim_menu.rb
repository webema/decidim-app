Decidim.menu :admin_menu do |menu|
  menu.remove_item :newsletters
  menu.item I18n.t('admin_menu.newsletters', scope: 'decidim.ema'),
            '/admin/newsletters',
            icon_name: 'envelope-closed',
            position: 7.2,
            active: :inclusive,
            if: true
end