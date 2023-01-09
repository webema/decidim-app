class AddEmaSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :ema_surveys do |t|
      t.string :title
      t.text :intro
      t.text :outro
      t.string :url
      t.boolean :active, default: false
      t.belongs_to :decidim_organization

      t.timestamps
    end
  end
end
