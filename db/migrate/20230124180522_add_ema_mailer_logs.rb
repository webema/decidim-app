class AddEmaMailerLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :ema_sent_emails do |t|
      t.string :mailer
      t.string :action
      t.string :mailer_action
      t.string :to
      t.string :from
      t.string :subject

      t.timestamps
    end
  end
end
