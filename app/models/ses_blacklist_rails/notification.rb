module SesBlacklistRails
  class Notification < ApplicationRecord # :nodoc:
    self.table_name = :ses_notifications

    enum notification_type: {
      bounce: 0,
      complaint: 1,
      delivery: 2,
      other: 9
    }
  end
end
