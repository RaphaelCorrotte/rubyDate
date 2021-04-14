require "time"
require "date"
require "yaml"
require_relative "formatter"

module RubyDate
  class Duration
    attr_reader :relative_format_path, :relative_format_data, :duration
    attr_accessor :time, :lang
    def initialize(lang, time = 0, relative_format_path = "lib/data/relativeFormat.yml")
      @lang, @time, @relative_format_path = lang, time, relative_format_path
      @relative_format_data = YAML::load(File.open(@relative_format_path))
    end
    def format(format, viewer = nil, options = { :object => false, :array => false })
      timestamp = (Time.new + @time) - Time.new
      seconds = Time.strptime("#{timestamp}", "%s").to_i # seconds from epoch
      minutes, seconds_left, hours, minutes_left, days, hours_left, days_left, years = 0, 0, 0, 0, 0, 0, 0, 0
      if seconds >= 60
        minutes, seconds_left = seconds.divmod(60)
        if minutes >= 60
          hours, minutes_left = minutes.divmod(60)
          if hours >= 24
            days, hours_left = hours.divmod(24)
            if days >= 365
              years = days.divmod(365)[0]
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
            :years => years > 1 ? :yy : :y
          }
          strings = {}
          formats.each do |key, value|
            next if duration[key][:left] === 0 and key != :seconds or duration[key][:total] === 0
            unless @relative_format_data[value][@lang]; raise "No lang found : #{@lang}"; end
            strings[key] = "#{@relative_format_data[value][@lang]}"
          end
          format_date_duration = []
          strings.each_value do |value|
            format_date_duration << "#{value}"
          end
          format_date_duration.each do |duration_string|
            # Replace by seconds
            if duration_string.include? "[%ss]"
              duration_string["[%ss]"] = seconds_left.to_s
              next
            end
            # Replace by minutes
            if duration_string.include? "[%mm]"
              duration_string["[%mm]"] = minutes_left.to_s
              next
            end
            # Replace by hours
            if duration_string.include? "[%hh]"
              duration_string["[%hh]"] = hours_left.to_s
              next
            end
            # Replace by days
            if duration_string.include? "[%dd]"
              duration_string["[%dd]"] = days_left.to_s
              next
            end
            # Replace by years
            if duration_string.include? "[%yy]"
              duration_string["[%yy]"] = years.to_s
              next
            end
          end
        else
          value = nil
          case viewer
          when :seconds
            value = duration[:seconds][:total]
          when :minutes
            value = duration[:minutes][:total]
          when :hours
            value = duration[:hours][:total]
          when :days
            value = duration[:days][:total]
          when :years
            value = duration[:years][:total]
          else
            value = "No viewer format : #{viewer}"
          end
          return  value
        end
        format_date_duration.reverse!
        if options[:array]
          return format_date_duration
        end
        if format_date_duration.length > 1
        separate_format_array = format_date_duration.slice 0, format_date_duration.length - 1
        end_of_format_array = format_date_duration.slice -1
        [separate_format_array.join(", "), end_of_format_array].join(" #{@relative_format_data[:a][@lang]} ")
        else
          format_date_duration
        end
      end
    end
  end
end

