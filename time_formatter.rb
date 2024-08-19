

class TimeFormatter
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  attr_reader :errors

  def initialize(format_params)
    @format_params = format_params
    @valid_formats, @errors = resolve_formats
  end

  def formatted_time
    format_string = @valid_formats.map { |format| TIME_FORMATS[format] }.join('-')
    Time.now.strftime(format_string)
  end

  private

  def resolve_formats
    valid_formats = []
    errors = []

    @format_params.each do |format|
      if TIME_FORMATS.key?(format)
        valid_formats << format
      else
        errors << format
      end
    end

    [valid_formats, errors]
  end
end
