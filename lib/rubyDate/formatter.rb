require "date"
require "time"
require "yaml"
require_relative "constants"

module RubyDate
  class Formatter
    attr_reader :date, :format_data
    attr_accessor :locale, :formats_path, :langs_path

    def initialize(locale, date = Time.new, formats_path = "lib/data/formats.yml", langs_path = "lib/data/langs.yml")
      @locale, @date, @formats_path, @langs_path = locale, date, formats_path, langs_path
      @format_data = YAML::load(File.open(@formats_path))
      @lang_data = YAML::load(File.open(@langs_path))
    end

    def format(format)
      date = @date.to_datetime.strftime(format)
      case @locale
      when :en
        date
      else
        if @format_data[@locale]
          @lang_data[:months][@locale].each_key do |key|
            next unless date.include?(key)
            date[key] = @lang_data[:months][@locale][key]
          end
          @lang_data[:days][@locale].each_key do |key|
            next unless date.include?(key)
            date[key] = @lang_data[:days][@locale][key]
          end
          date
        else raise "Bad locale format #{@locale}"; end
      end
    end
  end
end