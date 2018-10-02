module SesBlacklistRails
  class Notification < ApplicationRecord # :nodoc:
    self.table_name = :ses_notifications

    enum notification_type: {
      bounce: 0,
      complaint: 1,
      delivery: 2,
      other: 9
    }
    
    class << self
      def validate_bounce
        @validate_bounce ||= ->(email) { self.bounce.where(email: email).any? }
      end

      def validate_complaint
        @validate_complaint ||= ->(email) { self.complaint.where(email: email).any? }
      end
    end
  end
end
