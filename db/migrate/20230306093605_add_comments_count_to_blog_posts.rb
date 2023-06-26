class AddCommentsCountToBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :ema_blog_posts, :comments_count, :integer, default: 0, null: false
  end
end
