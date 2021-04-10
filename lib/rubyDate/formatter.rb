require_relative "constants"
require "date"
require "time"

module RubyDate
  class Formatter
    attr_reader :date
    attr_accessor :locale

    def initialize(locale, date = Time.new)
      @locale, @date = locale, date
    end

    def format(format)
      date = @date.to_datetime.strftime(format).to_s
      case locale
      when :en
        date
      else
        if RubyDate::Constants::FORMATS[@locale]
          RubyDate::Constants::LANGS[@locale][:months].each_key do |key|
            unless date.include?(key); next; end
            p RubyDate::Constants::LANGS[@locale][:months][key]
            date[key] = RubyDate::Constants::LANGS[@locale][:months][key]
          end
          RubyDate::Constants::LANGS[@locale][:days].each_key do |key|
            unless date.include?(key); next; end
            if date.include?(key) then date[key] = RubyDate::Constants::LANGS[@locale][:days][key]; end
          end
          date
        else raise "Bad locale format #{@locale}"; end
      end
    end
  end
end