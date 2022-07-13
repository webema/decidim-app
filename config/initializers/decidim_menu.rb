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
end

Decidim.content_blocks.register(:homepage, :highlighted_blog_posts) do |content_block|
  content_block.cell = 'decidim/blog_posts_content_block/content_blocks/highlighted_blog_posts'
  content_block.public_name_key = 'decidim.blog_posts_content_block.content_blocks.highlighted_blog_posts.name'
end
