require 'rails_helper'

module SesBlacklistRails
  RSpec.describe Api::NotificationController, type: :request do
    include SesBlacklistRails::Engine.routes.url_helpers

    describe 'POST /api/notification' do
      let(:fixture_path) { Rails.root.join('..', 'fixture', 'ses', 'response') }

      context 'Undetectable request' do
        let(:param) { '{"message": "this is mysterious message"}' }
        before { post api_notification_path, params: param }

        it { expect(response.status).to eq 403 }
        it {
          expect(
            eval(Notification.order(:id)
                             .find_by(notification_type: :other)
                             .try(:log))
          ).to eq eval(param)
        }
      end

      context 'SubscriptionConfirmation' do
        context 'POSTed valid JSON' do
          let(:param) { File.read(fixture_path.join('subscription_confirmation.json')) }
          context 'fail confirmation' do
            before do
              stub_request(:get, 'https://sns.us-west-2.amazonaws.com/?Action=ConfirmSubscription&Token=2336412f37fb687f5d51e6e241d09c805a5a57b30d712f794cc5f6a988666d92768dd60a747ba6f3beb71854e285d6ad02428b09ceece29417f1f02d609c582afbacc99c583a916b9981dd2728f4ae6fdb82efd087cc3b7849e05798d2d2785c03b0879594eeac82c01f235d0e717736&TopicArn=arn:aws:sns:us-west-2:123456789012:MyTopic')
                .with(headers: { 'Accept' => '*/*',
                                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                                 'Host' => 'sns.us-west-2.amazonaws.com',
                                 'User-Agent' => 'Ruby' })
                .to_return(status: 403, body: '', headers: {})
              post api_notification_path, params: param
            end
            subject { response.status }
            it { is_expected.to eq 500 }

            it {
              expect(
                eval(Notification.order(:id)
                                 .find_by(notification_type: :other)
                                 .try(:log))
              ).to eq eval(param)
            }
          end

          context 'success confirmation' do
            before do
              stub_request(:get, 'https://sns.us-west-2.amazonaws.com/?Action=ConfirmSubscription&Token=2336412f37fb687f5d51e6e241d09c805a5a57b30d712f794cc5f6a988666d92768dd60a747ba6f3beb71854e285d6ad02428b09ceece29417f1f02d609c582afbacc99c583a916b9981dd2728f4ae6fdb82efd087cc3b7849e05798d2d2785c03b0879594eeac82c01f235d0e717736&TopicArn=arn:aws:sns:us-west-2:123456789012:MyTopic')
                .with(headers: { 'Accept' => '*/*',
                                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                                 'Host' => 'sns.us-west-2.amazonaws.com',
                                 'User-Agent' => 'Ruby' })
                .to_return(status: 200, body: '', headers: {})
              post api_notification_path, params: param
            end
            subject { response.status }
            it { is_expected.to eq 204 }

            it {
              expect(
                eval(Notification.order(:id)
                                 .find_by(notification_type: :other)
                                 .try(:log))
              ).to eq eval(param)
            }
          end
        end
      end

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
