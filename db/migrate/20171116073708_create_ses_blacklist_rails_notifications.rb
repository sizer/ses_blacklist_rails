class CreateSesBlacklistRailsNotifications < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    create_table :ses_notifications do |t|
      t.integer :notification_type, null: false, default: 0
      t.string  :email,             null: false, default: ''
      t.text    :log,               null: false, default: ''

      t.timestamps
    end
  end
end
