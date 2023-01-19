class AddButtonTextToSurveys < ActiveRecord::Migration[6.1]
  def change
    add_column :ema_surveys, :accept_button_text, :string
    add_column :ema_surveys, :decline_button_text, :string
  end
end
