class Time
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env
    _status, headers, _body = @app.call(@env)

    if valid_query?
      [200, headers, [formatted_time]]
    else
      [400, headers, ["Unknown time format [#{invalid_formats.join(', ')}]"]]
    end
  end

  private

  def valid_query?
    invalid_formats.empty?
  end

  def invalid_formats
    params['format']&.split(',')&.reject { |f| TIME_FORMATS.key?(f) } || []
  end

  def formatted_time
    requested_formats = params['format']&.split(',') || []
    format_string = requested_formats.map { |f| TIME_FORMATS[f] }.join('-')
    Time.now.strftime(format_string)
  end

  def params
    Rack::Utils.parse_nested_query(@env['QUERY_STRING'])
  end
end
