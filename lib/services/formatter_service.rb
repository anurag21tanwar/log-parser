# frozen_string_literal: true

require_relative '../errors/errors'
require 'uri'
require 'resolv'

module FormatterService
  # InputData class could be used for formatting input as per need
  class InputData
    SPLIT_BY = ' '

    attr_reader :input_data, :split_data

    def initialize(input_data)
      @input_data = input_data
    end

    def call
      @split_data = input_data.split(SPLIT_BY)
      check_split_data
      split_data
    end

    private

    def check_split_data
      raise Errors::InvalidFileInputLineData unless split_data.length == 2
      raise Errors::InvalidFileInputLineDataTypeUrl unless check_url_path? split_data[0]
      raise Errors::InvalidFileInputLineDataTypeIp unless check_ip? split_data[1]
    end

    def check_url_path?(url_path)
      URI.parse("http://127.0.0.1:3000/#{url_path}")
    rescue StandardError
      false
    end

    def check_ip?(_ip)
      #### TODO: existing webserver.log file does not have valid ip addr ranges
      #### can enable this check to have an extra ip validation
      # ip =~ Resolv::IPv4::Regex
      true
    end
  end

  # OutputData class could be used for formatting output as per need
  class OutputData
    JOIN_BY = ' '

    attr_reader :data_hashmap, :std_out

    def initialize(data_hashmap)
      @data_hashmap = data_hashmap
    end

    def call(std_out: true)
      @std_out = std_out
      webpages_with_most_views
      webpages_with_most_uniq_views
    end

    private

    def webpages_with_most_views
      ordered = data_hashmap.sort_by { |_, v| -v.length }
      return ordered unless std_out

      p '1) list of webpages with most page views ordered from most pages views to less page views:'
      ordered.each do |k, v|
        p format_output(k, "#{v.length} visits")
      end
    end

    def webpages_with_most_uniq_views
      ordered = data_hashmap.sort_by { |_, v| -v.uniq.length }
      return ordered unless std_out

      p '2) list of webpages with most unique page views also ordered:'
      ordered.each do |k, v|
        p format_output(k, "#{v.uniq.length} unique views")
      end
    end

    def format_output(url_path, visit_data)
      [JOIN_BY * 4, '*', url_path, visit_data].join(JOIN_BY)
    end
  end
end
