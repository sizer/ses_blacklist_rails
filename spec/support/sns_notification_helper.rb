module SnsNotificationHelper
  def sns_notification(message)
    { Type: 'Notification', Message: message }.to_json
  end
end
