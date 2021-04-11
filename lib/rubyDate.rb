require_relative "rubyDate/version"
require_relative "rubyDate/formatter"
require_relative "rubyDate/constants"
require_relative "rubyDate/duration"

puts RubyDate::Duration.new(Time.new + 3600).format("")