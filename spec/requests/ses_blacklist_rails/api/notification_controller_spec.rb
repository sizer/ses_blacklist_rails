require 'rails_helper'

module SesBlacklistRails
  RSpec.describe Api::NotificationController, type: :request do
    include SesBlacklistRails::Engine.routes.url_helpers

    describe 'POST /api/notification' do
      let(:fixture_path) { Rails.root.join('..', 'fixture', 'ses', 'response') }

      context 'BoundMail' do
        context 'with DSN' do
          let(:param) { File.read(fixture_path.join('bounce_dsn.json')) }
          it 'returns no_contents' do
            post api_notification_path, params: param
            expect(response.status).to eq 204
          end
        end

        context 'without DSN' do
          let(:param) { File.read(fixture_path.join('bounce.json')) }
          it 'returns no_contents' do
            post api_notification_path, params: param
            expect(response.status).to eq 204
          end
        end
      end

      context 'Complaint' do
        context 'with feedback report' do
          let(:param) { File.read(fixture_path.join('complaint_feedback.json')) }
          it 'returns no_contents' do
            post api_notification_path, params: param
            expect(response.status).to eq 204
          end
        end

        context 'without feedback report' do
          let(:param) { File.read(fixture_path.join('complaint.json')) }
          it 'returns no_contents' do
            post api_notification_path, params: param
            expect(response.status).to eq 204
          end
        end
      end

      context 'Delivery' do
        context 'with feedback report' do
          let(:param) { File.read(fixture_path.join('delivery.json')) }
          it 'returns no_contents' do
            post api_notification_path, params: param
            expect(response.status).to eq 204
          end
        end
      end
    end
  end
end
