require "time"
require "date"
require "yaml"
require_relative "formatter"

module RubyDate
  class Duration
    attr_reader :relative_format_path, :relative_format_data, :duration
    attr_accessor :time, :lang
    def initialize(lang, time = Time.new, relative_format_path = "lib/data/relativeFormat.yml")
      @lang, @time, @relative_format_path = lang, time, relative_format_path
      @relative_format_data = YAML::load(File.open(@relative_format_path))
    end
    def format(format, viewer = nil, options = { :object => false  })
      timestamp = @time - Time.new
      seconds = Time.strptime("#{timestamp}", "%s").to_i + 1 # seconds from epoch
      minutes, seconds_left, hours, minutes_left, days, hours_left, months, days_left, years, months_left = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      if seconds >= 60
        minutes, seconds_left = seconds.divmod(60)
        if minutes >= 60
          hours, minutes_left = minutes.divmod(60)
          if hours >= 24
            days, hours_left = hours.divmod(24)
            if days >= 30
              months, days_left = days.divmod(30)
              if months >= 12
                years, months_left = months.divmod(12)
              end
            end
          end
        end
      end
      duration = Hash[
        :seconds => Hash[
          :total => seconds,
          :left => seconds_left
        ],
        :minutes => Hash[
          :total => minutes,
          :left => minutes_left
        ],
        :hours => Hash[
          :total => hours,
          :left => hours_left
        ],
        :days => Hash[
          :total => days,
          :left => days_left
        ],
        :months => Hash[
          :total => months,
          :left => months_left
        ],
        :years => Hash[
          :total => years
        ]
      ]
      if options[:object]
        duration
      else
        if viewer.nil?
          formats = {
            :seconds => seconds_left > 1 ? :ss : :s,
            :minutes => minutes_left > 1 ? :mm : :m,
            :hours => hours_left > 1 ? :hh : :h,
            :days => days_left > 1 ? :dd : :d,
            :months => months_left > 1 ? :MM : :M,
            :years => years > 1 ? :yy : :y
          }
          strings = {}
          formats.each do |key, value|
            next if duration[key][:left] === 0 or duration[key][:total] === 0
            unless @relative_format_data[value][@lang]; raise "No lang found : #{@lang}"; end
            puts "Check #{key} : #{@relative_format_data[value][@lang]}"
            strings[key] = "#{@relative_format_data[value][@lang]}"
          end
          duration_date = ""
          strings.each do |key, value|
            duration_date << "#{value} "
            # Replace by seconds
            if duration_date.include? "[%ss]"
              duration_date["[%ss]"] = seconds_left.to_s
              next
            end
            # Replace by minutes
            if duration_date.include? "[%mm]"
              duration_date["[%mm]"] = minutes_left.to_s
              next
            end
            # Replace by hours
            if duration_date.include? "[%hh]"
              duration_date["[%hh]"] = hours_left.to_s
              next
            end
            # Replace by days
            if duration_date.include? "[%dd]"
              duration_date["[%dd]"] = days_left.to_s
              next
            end
            # Replace by months
            if duration_date.include? "[%MM]"
              duration_date["[%MM]"] = months_left.to_s
              next
            end
            # Replace by years
            if duration_date.include? "[%yy]"
              duration_date["[%yy]"] = years.to_s
              next
            end
          end
          duration_date
        else
        end
      end
    end
  end
end

