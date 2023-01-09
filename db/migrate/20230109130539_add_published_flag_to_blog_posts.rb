class AddPublishedFlagToBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :ema_blog_posts, :published, :boolean, default: true
  end
end
