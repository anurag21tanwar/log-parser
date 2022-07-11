# frozen_string_literal: true

require_relative '../../lib/services/formatter_service'

# ProcessLogService is used for processing the log data line by line
class ProcessLogService
  attr_reader :data_hashmap, :data

  def initialize(data_hashmap, data)
    @data_hashmap = data_hashmap
    @data = data.chomp
  end

  def call
    url_path, ip = FormatterService::InputData.new(data).call
    update_data_hashmap(url_path, ip)
  end

  private

  def update_data_hashmap(url_path, ip)
    if data_hashmap.key? url_path
      data_hashmap[url_path] << ip
    else
      data_hashmap[url_path] = [ip]
    end
  end
end
