require 'rails/generators'

module SesBlacklistRails
  module Generators
    class InstallGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path('../../templates', __FILE__)
      desc 'Creates a SesBlacklistRails initializer and copy locale files to your application.'

      class_option 'with-migrate', type: :boolean

      def start
        puts 'Start installing SesBlacklistRails...'
        puts '*' * 80 + "\n"
      end

      def install_migrations
        puts 'Copying SesBlacklistRails migrations...'
        Dir.chdir(Rails.root) do
          `rake ses_blacklist_rails:install:migrations`
        end
      end

      def run_migrations
        return unless options['with-migrate']
        puts 'Running rake db:migrate'
        `rake db:migrate`
      end

      def copy_initializer
        puts 'Copying initializer template...'
        template 'ses_blacklist_rails.rb', 'config/initializers/ses_blacklist_rails.rb'
      end

      def finished
        puts "\n" + ('*' * 80)
        puts 'Done! SesBlacklistRails has been successfully installed.'
      end
    end
  end
end
