Decidim.content_blocks.register(:homepage, :zukunftsprozess) do |content_block|
  content_block.cell = 'decidim/zukunftsprozess_content_block/content_blocks/startpage'
  content_block.public_name_key = 'decidim.zukunftsprozess_content_block.content_blocks.startpage.name'
end

Decidim.content_blocks.register(:homepage, :recent_blog_posts) do |content_block|
  content_block.cell = 'decidim/blog_posts_content_block/content_blocks/recent_blog_posts'
  content_block.public_name_key = 'decidim.blog_posts_content_block.content_blocks.recent_blog_posts.name'
end

Decidim.content_blocks.register(:homepage, :active_proposal_collections) do |content_block|
  content_block.cell = 'decidim/active_proposal_collections_content_block/content_blocks/active_proposal_collections'
  content_block.public_name_key = 'decidim.active_proposal_collections_content_block.content_blocks.active_proposal_collections.name'
end
