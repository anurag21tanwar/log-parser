# frozen_string_literal: true

require_relative '../lib/services/process_log_service'
require_relative 'errors/errors'

def main
  file_validation(ARGV[0])

  data_hashmap = {}
  File.foreach(ARGV[0]) do |line_data|
    process_line_data(data_hashmap, line_data)
  end
  FormatterService::OutputData.new(data_hashmap).call
rescue StandardError => e
  p e.message
end

def file_validation(file_path)
  raise Errors::LogFileNotFound unless File.file?(file_path)
  raise Errors::LogFileEmpty if File.zero?(file_path)
end

def process_line_data(data_hashmap, line_data)
  ProcessLogService.new(data_hashmap, line_data).call
rescue Errors::InvalidFileInputLineData,
       Errors::InvalidFileInputLineDataTypeUrl,
       Errors::InvalidFileInputLineDataTypeIp => e
  p "#{e.message}, ignoring this input line: #{line_data}"
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------
main
