module SesBlacklistRails
  class Notification < ApplicationRecord # :nodoc:
    self.table_name = :ses_notifications
  end
end
