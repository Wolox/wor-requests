# Wolox on Rails - Requests

This gem lets you easily add to your service objects the ability to make external requests, logging everything so you don't have to worry about that.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wor-requests'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wor-requests

Then you can modify the default configurations:

```ruby
# config/initializers/wor_requests.rb

Wor::Requests.configure do |config|
  config.logger = Rails.logger
end
```

## Usage

```ruby
require 'wor/requests'

class GithubService < Wor::Requests::Base
  def repositories(username)
    get(
      attempting_to: "get repositories of #{username}",
      path: "/users/#{username}/repos"
    )
  rescue Wor::Requests::RequestError => e
    puts e.message
  end

  protected

  def base_url
    'https://api.github.com'
  end
end

puts GithubService.new.repositories('alebian')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rubocop lint (`rubocop -R --format simple`)
5. Run rspec tests (`bundle exec rspec`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request

## About ##

This project was written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
