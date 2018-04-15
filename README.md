# Memobird

封装咕咕机[官方API](http://open.memobird.cn/upload/webapi.pdf)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'memobird'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memobird

## Usage

```ruby
require 'memobird'

Memobird.api_key = '申请的AK'
Memobird.memobird_id = '咕咕机设备编号'
Memobird.user_identifying = 'App账户的咕咕号'

Memobird.print_content(text: Time.now.inspect)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
