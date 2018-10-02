# SesBlacklistRails
[![Gem Version](https://badge.fury.io/rb/ses_blacklist_rails.svg)](https://badge.fury.io/rb/ses_blacklist_rails)
[![CircleCI](https://circleci.com/gh/mrdShinse/sns_blacklist_rails/tree/master.svg?style=svg)](https://circleci.com/gh/mrdShinse/sns_blacklist_rails/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/4f1e146157fdfacbdde1/maintainability)](https://codeclimate.com/github/mrdShinse/sns_blacklist_rails/maintainability)
[![Dependency Status](https://gemnasium.com/badges/github.com/mrdShinse/sns_blacklist_rails.svg)](https://gemnasium.com/github.com/mrdShinse/sns_blacklist_rails)

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
  config.send_complaint = false
  config.default_address = 'some_address@sample.com'
end
```

## Contributing
Please let me know if you found any problems, by creating ISSUE reports or PRs.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
