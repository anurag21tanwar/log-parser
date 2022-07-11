# frozen_string_literal: true

module Errors
  # custom LogFileNotFound error class
  class LogFileNotFound < StandardError
    def message
      'Log file not found'
    end
  end

  # custom LogFileEmpty error class
  class LogFileEmpty < StandardError
    def message
      'Log file is empty'
    end
  end

  # custom InvalidFileInputLineData error class
  class InvalidFileInputLineData < StandardError
    def message
      'Invalid input line data'
    end
  end

  # custom InvalidFileInputLineDataTypeUrl error class
  class InvalidFileInputLineDataTypeUrl < StandardError
    def message
      'Invalid input line data, url path incorrect'
    end
  end

  # custom InvalidFileInputLineDataTypeIp error class
  class InvalidFileInputLineDataTypeIp < StandardError
    def message
      'Invalid input line data, ip addr incorrect'
    end
  end
end
