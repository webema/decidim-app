class AddEmaBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :ema_blog_posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
