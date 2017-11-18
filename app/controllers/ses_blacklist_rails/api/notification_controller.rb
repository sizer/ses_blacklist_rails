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
            Notification.create(
              notification_type: Notification.notification_types[:bounce],
              email: r[:emailAddress],
              log: @params
            )
          end
        when 'Complaint'
          @params[:complaint][:complainedRecipients].each do |r|
            Notification.create(
              notification_type: Notification.notification_types[:complaint],
              email: r[:emailAddress],
              log: @params
            )
          end
        when 'Delivery'
          @params[:delivery][:recipients].each do |r|
            Notification.create(
              notification_type: Notification.notification_types[:delivery],
              email: r,
              log: @params
            )
          end
        end
      end

      private

      def parse_request
        @params ||= JSON.parse(request.body.read, symbolize_names: true)
      end
    end
  end
end
