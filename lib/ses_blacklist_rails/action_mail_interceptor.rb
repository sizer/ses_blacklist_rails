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
          validate_bounce = ->(email) { SesBlacklistRails::Notification.compliant.find_by(email: email) }
          message.to.reject!(validate_bounce)
          message.cc.reject!(validate_bounce)
          message.bcc.reject!(validate_bounce)
        end

        defualt_address!(message) if message.to.blank?
        message
      end

      def defualt_address!(message)
        message.to << SesBlacklistRails::Notification.default_address
        message
      end
    end
  end
end
