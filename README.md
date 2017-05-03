# Wolox on Rails - Requests
[![Build Status](https://travis-ci.org/Wolox/wor-requests.svg)](https://travis-ci.org/Wolox/wor-requests)
[![Code Climate](https://codeclimate.com/github/Wolox/wor-requests/badges/gpa.svg)](https://codeclimate.com/github/Wolox/wor-requests)
[![Test Coverage](https://codeclimate.com/github/Wolox/wor-requests/badges/coverage.svg)](https://codeclimate.com/github/Wolox/wor-requests/coverage)
[![Issue Count](https://codeclimate.com/github/Wolox/wor-requests/badges/issue_count.svg)](https://codeclimate.com/github/Wolox/wor-requests)

Make external requests in you service objects, with easy logging and error handling!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wor-requests'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wor-requests

Then you can run `rails generate wor:requests:install` to create the initializer:

```ruby
# config/initializers/wor_requests.rb

Wor::Requests.configure do |config|
  config.logger = Rails.logger
end
```

## Usage

To write your first Service using Wor-requests you can write something like this:

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

Or, even easier, run `rails generate wor:requests:service NAME` in your Rails root

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rubocop lint (`rubocop -R --format simple`)
5. Run rspec tests (`bundle exec rspec`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request

## About ##

This project is maintained by [Diego Raffo](https://github.com/enanodr) along with [Michel Agopian](https://github.com/mishuagopian) and it was written by [Wolox](http://www.wolox.com.ar).
![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)

## License

**wor-requests** is available under the MIT [license](https://raw.githubusercontent.com/Wolox/wor-requests/master/LICENSE.md).

    Copyright (c) 2017 [Wolox](http://www.wolox.com.ar)

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
