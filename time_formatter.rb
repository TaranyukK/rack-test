class TimeFormatter
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  def initialize(format_params)
    @format_params = format_params
  end

  def formatted_time
    if invalid_formats.empty?
      format_string = @format_params.map { |f| TIME_FORMATS[f] }.join('-')
      Time.now.strftime(format_string)
    else
      nil
    end
  end

  def invalid_formats
    @format_params.reject { |f| TIME_FORMATS.key?(f) }
  end

  def valid?
    invalid_formats.empty?
  end
end
