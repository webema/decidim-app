class AddHideImageFlagForBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :ema_blog_posts, :hide_hero_image, :boolean, default: false
  end
end
