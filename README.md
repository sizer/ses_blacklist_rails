# SesBlacklistRails
Short description and motivation.

## Installation
Add this line to your application's `Gemfile`:

```ruby
gem 'ses_blacklist_rails'
```

And then execute:
```bash
$ bundle
$ bundle exec rails g ses_blacklist_rails:install
```

## Configuration

`in config/initializers/ses_blacklist_rails.rb`
```ruby
SesBlacklistRails.configure do |config|
  config.send_bounce = false
  config.send_compliant = false
  config.default_address = 'some_address@sample.com'
end
```

## Contributing
Please let me know if you found any problems, by creating ISSUE reports or PRs.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
