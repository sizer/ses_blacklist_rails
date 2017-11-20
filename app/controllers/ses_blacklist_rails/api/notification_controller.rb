require_dependency 'ses_blacklist_rails/application_controller'

module SesBlacklistRails
  module Api
    class NotificationController < ApplicationController # :nodoc:
      skip_before_action :verify_authenticity_token
      before_action :parse_request

      def index
        case @params[:notificationType]
        when 'Bounce'
          @params[:bounce][:bouncedRecipients].each do |r|
            create_notification(r, :bounce)
          end
        when 'Complaint'
          @params[:complaint][:complainedRecipients].each do |r|
            create_notification(r, :complaint)
          end
        when 'Delivery'
          @params[:delivery][:recipients].each do |r|
            create_notification(r, :delivery)
          end
        end
      end

      private

      def parse_request
        @params ||= JSON.parse(request.body.read, symbolize_names: true)
      end

      def create_notification(recipient, type)
        Notification.create(
          notification_type: Notification.notification_types[type],
          email: type == :delivery ? recipient : recipient[:emailAddress],
          log: @params
        )
      end
    end
  end
end
