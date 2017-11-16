module SesBlacklistRails
  class Engine < ::Rails::Engine # :nodoc:
    isolate_namespace SesBlacklistRails

    config.generators do |g|
      g.test_framework :rspec, fixture: false
    end
  end
end
