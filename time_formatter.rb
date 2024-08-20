class TimeFormatter
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  Result = Struct.new(:time_string, :errors) do
    def valid?
      errors.empty?
    end

    def invalid_string
      "Invalid formats: [#{errors.join(', ')}]"
    end
  end

  def initialize(format_params)
    @format_params = format_params
    @resolved_formats = []
    @errors = []
  end

  def call
    resolve_formats
    time_string = Time.now.strftime(@resolved_formats.join('-')) if @errors.empty?
    Result.new(time_string, @errors)
  end

  private

  def resolve_formats
    @format_params.each do |format|
      if TIME_FORMATS.key?(format)
        @resolved_formats << TIME_FORMATS[format]
      else
        @errors << format
      end
    end
  end
end
