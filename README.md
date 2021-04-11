![Les Laboratoires Ruby](https://invidget.switchblade.xyz/4P7XcmbDnt)


# RubyDate

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rubyDate`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is a date manager gem. This is useful to use.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyDate'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubyDate

## Usage

This is still in wip, but there a simple usage 
```rb
require "yaml"

file = YAML::load(File.open("lib/data/formats.yml"))

puts RubyDate::Formatter.new(:fr).format(file[:fr])
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rubyDate.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
