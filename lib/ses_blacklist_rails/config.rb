module SesBlacklistRails
  class Config # :nodoc:
    include ActiveSupport::Configurable

    config_accessor :send_bounce do
      false
    end

    config_accessor :send_complaint do
      false
    end

    config_accessor :default_address do
      ''
    end
  end
end
