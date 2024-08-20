class TimeFormatter
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  attr_reader :errors, :valid_formats

  def initialize(format_params)
    @format_params = format_params
    @valid_formats = []
    @errors = []
  end

  def call
    resolve_formats
  end

  def valid?
    @errors.empty?
  end

  def time_string
    return '' unless valid?

    Time.now.strftime(@valid_formats.join('-'))
  end

  def invalid_string
    "Invalid formats: #{@errors.join(', ')}"
  end

  private

  def resolve_formats
    @format_params.each do |format|
      if TIME_FORMATS.key?(format)
        @valid_formats << TIME_FORMATS[format]
      else
        @errors << format
      end
    end
  end
end
