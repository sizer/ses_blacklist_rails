class CreateSesBlacklistRailsNotifications < ActiveRecord::Migration[5.0] # :nodoc:
  def change
    create_table :ses_notifications do |t|
      t.integer :notification_type, null: false, default: 0
      t.string  :email,             null: false, default: ''
      t.text    :log,               null: false, default: ''

      t.timestamps
    end

    add_index :ses_notifications, %i[notification_type email]
  end
end
