module SesBlacklistRails
  class ActionMailInterceptor # :nodoc:
    class << self
      def delivering_email(message)
        validate!(message)
      end

      private

      def validate!(message)
        sanitize_destination! SesBlacklistRails::Notification.validate_bounce unless SesBlacklistRails::Config.send_bounce
        sanitize_destination! SesBlacklistRails::Notification.validate_compliant unless SesBlacklistRails::Config.send_compliant

        defualt_address!(message) if message.to.blank?
        message
      end

      def defualt_address!(message)
        if SesBlacklistRails::Config.default_address.blank?
          message.perform_deliveries = false
        else
          message.to << SesBlacklistRails::Config.default_address
        end
        message
      end
      
      def sanitize_destination!(message, validation)
        message.to.reject! &validation
        message.cc.reject! &validation
        message.bcc.reject! &validation
      end
    end
  end
end
