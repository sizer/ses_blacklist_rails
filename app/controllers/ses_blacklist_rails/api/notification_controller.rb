require_dependency 'ses_blacklist_rails/application_controller'

module SesBlacklistRails
  module Api
    class NotificationController < ApplicationController # :nodoc:
      skip_before_action :verify_authenticity_token
      before_action :parse_request

      def index
        if @params[:Type] == 'SubscriptionConfirmation'
          create_notification('', :other)
          begin
            uri = URI.parse @params[:SubscribeURL]
            res = Net::HTTP.get_response uri
            return render plain: '', status: 500 if res.code.to_i != 200
          rescue StandardError
            return render plain: '', status: 500
          end

        elsif @params[:Type] == 'Notification'
          message = @params[:Message]
          case message[:notificationType]
          when 'Bounce'
            message[:bounce][:bouncedRecipients].each do |r|
              create_notification(r, :bounce)
            end
          when 'Complaint'
            message[:complaint][:complainedRecipients].each do |r|
              create_notification(r, :complaint)
            end
          when 'Delivery'
            message[:delivery][:recipients].each do |r|
              create_notification(r, :delivery)
            end
          end
        else
          create_notification('', :other)
          render plain: '', status: 403
        end
      end

      private

      def parse_request
        @params ||= JSON.parse(request.body.read, symbolize_names: true)
      end

      def create_notification(recipient, type)
        Notification.create(
          notification_type: Notification.notification_types[type],
          email: %i[delivery other].include?(type) ? recipient : recipient[:emailAddress],
          log: @params
        )
      end
    end
  end
end
