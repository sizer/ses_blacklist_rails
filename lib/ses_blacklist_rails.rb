require 'ses_blacklist_rails/action_mail_interceptor'
require 'ses_blacklist_rails/config'
require 'ses_blacklist_rails/engine'

module SesBlacklistRails # :nodoc:
  def self.configure(*)
    yield config
  end

  def self.config
    @config ||= SesBlacklistRails::Config.new
  end
end
