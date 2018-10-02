SesBlacklistRails.configure do |config|
  config.send_bounce = false
  config.send_complaint = false
  config.default_address = 'some_address@sample.com'
end
