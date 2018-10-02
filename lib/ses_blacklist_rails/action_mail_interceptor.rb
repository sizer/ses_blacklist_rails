module SesBlacklistRails
  class ActionMailInterceptor # :nodoc:
    class << self
      def delivering_email(message)
        validate!(message)
      end

      private

      def validate!(message)
        sanitize_destination!(
          message,
          SesBlacklistRails::Notification.validate_bounce
        ) unless SesBlacklistRails.send_bounce
        sanitize_destination!(
          message,
          SesBlacklistRails::Notification.validate_complaint
        ) unless SesBlacklistRails.send_complaint

        defualt_address!(message) if message.to.blank?
        message
      end

      def defualt_address!(message)
        if SesBlacklistRails.default_address.blank?
          message.perform_deliveries = false
        else
          message.to = [SesBlacklistRails.default_address]
        end
        message
      end

      def sanitize_destination!(message, validation)
        message.to = message.to&.reject &validation
        message.cc = message.cc&.reject &validation
        message.bcc = message.bcc&.reject &validation
      end
    end
  end
end
