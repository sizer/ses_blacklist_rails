require 'rails_helper'

module SesBlacklistRails
  RSpec.describe Api::NotificationController, type: :request do
    include SesBlacklistRails::Engine.routes.url_helpers

    describe 'POST /api/notification' do
      let(:fixture_path) { Rails.root.join('..', 'fixture', 'ses', 'response') }

      context 'BoundMail' do
        context 'with DSN' do
          let(:param) { File.read(fixture_path.join('bounce_dsn.json')) }
          before { post api_notification_path, params: param }

          it { expect(response.status).to eq 204 }
          it { expect { post api_notification_path, params: param }.to(change { Notification.count }) }
          it {
            expect(Notification.last.notification_type_before_type_cast)
              .to eq(Notification.notification_types[:bounce])
          }
          it {
            expect(Notification.find_by(email: 'jane@example.com',
                                        notification_type: Notification.notification_types[:bounce])).to be_truthy
          }
        end

        context 'without DSN' do
          let(:param) { File.read(fixture_path.join('bounce.json')) }
          before { post api_notification_path, params: param }

          it { expect(response.status).to eq 204 }
          it { expect { post api_notification_path, params: param }.to(change { Notification.count }) }
          it {
            expect(Notification.last.notification_type_before_type_cast)
              .to eq(Notification.notification_types[:bounce])
          }
          it {
            expect(Notification.find_by(email: 'jane@example.com',
                                        notification_type: Notification.notification_types[:bounce])).to be_truthy
          }
          it {
            expect(Notification.find_by(email: 'richard@example.com',
                                        notification_type: Notification.notification_types[:bounce])).to be_truthy
          }
        end
      end

      context 'Complaint' do
        context 'with feedback report' do
          let(:param) { File.read(fixture_path.join('complaint_feedback.json')) }
          before { post api_notification_path, params: param }

          it { expect(response.status).to eq 204 }
          it { expect { post api_notification_path, params: param }.to(change { Notification.count }) }
          it {
            expect(Notification.last.notification_type_before_type_cast)
              .to eq(Notification.notification_types[:complaint])
          }
          it {
            expect(Notification.find_by(email: 'richard@example.com',
                                        notification_type: Notification.notification_types[:complaint])).to be_truthy
          }
        end

        context 'without feedback report' do
          let(:param) { File.read(fixture_path.join('complaint.json')) }
          before { post api_notification_path, params: param }

          it { expect(response.status).to eq 204 }
          it { expect { post api_notification_path, params: param }.to(change { Notification.count }) }
          it {
            expect(Notification.last.notification_type_before_type_cast)
              .to eq(Notification.notification_types[:complaint])
          }
          it {
            expect(Notification.find_by(email: 'richard@example.com',
                                        notification_type: Notification.notification_types[:complaint])).to be_truthy
          }
        end
      end

      context 'Delivery' do
        context 'with feedback report' do
          let(:param) { File.read(fixture_path.join('delivery.json')) }
          before { post api_notification_path, params: param }

          it { expect(response.status).to eq 204 }
          it { expect { post api_notification_path, params: param }.to(change { Notification.count }) }
          it {
            expect(Notification.last.notification_type_before_type_cast)
              .to eq(Notification.notification_types[:delivery])
          }
          it {
            expect(Notification.find_by(email: 'jane@example.com',
                                        notification_type: Notification.notification_types[:delivery])).to be_truthy
          }
        end
      end
    end
  end
end
