module SesBlacklistRails
  class ActionMailInterceptor # :nodoc:
    class << self
      def delivering_email(message)
        validate!(message)
      end

      private

      def validate!(message)
        unless SesBlacklistRails.send_bounce
          validate_bounce = ->(email) { SesBlacklistRails::Notification.bounce.find_by(email: email) }
          message.to.reject!(validate_bounce)
          message.cc.reject!(validate_bounce)
          message.bcc.reject!(validate_bounce)
        end

        unless SesBlacklistRails.send_compliant
          validate_compliant = ->(email) { SesBlacklistRails::Notification.compliant.find_by(email: email) }
          message.to.reject!(validate_compliant)
          message.cc.reject!(validate_compliant)
          message.bcc.reject!(validate_compliant)
        end

        defualt_address!(message) if message.to.blank?
        message
      end

      def defualt_address!(message)
        if SesBlacklistRails.default_address.blank?
          message.perform_deliveries = false
        else
          message.to << SesBlacklistRails.default_address
        end
        message
      end
    end
  end
end
