require "time"
require "date"
require "yaml"
require_relative "formatter"

module RubyDate
  class Duration
    attr_reader :lang_path, :lang_data
    attr_accessor :time
    def initialize(time = Time.new, lang_path = "lib/data/duration/langs.yml")
      @time, @lang_path = time, lang_path
      @lang_data = YAML::load(File.open(@lang_path))
    end
    def format(format)
      date = Time.strptime("#{@time.to_i - Time.new.to_i}", "%s")
      puts test
      if(@lang_data[format])
        date
      else
        RubyDate::Formatter.new(:fr, date).format("%A %d %B %Y %T")
      end
    end
  end
end
