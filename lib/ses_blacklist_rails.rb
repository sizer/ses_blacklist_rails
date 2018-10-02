require 'ses_blacklist_rails/action_mail_interceptor'
require 'ses_blacklist_rails/config'
require 'ses_blacklist_rails/engine'

module SesBlacklistRails # :nodoc:
  class << self
    def configure(*)
      yield config
    end

    def config
      @config ||= SesBlacklistRails::Config.new
    end

    delegate :send_bounce,     to: :config
    delegate :send_compliant,  to: :config
    delegate :default_address, to: :config
  end
end
