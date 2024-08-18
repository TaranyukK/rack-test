class Time
  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env
    _status, headers, _body = @app.call(@env)

    params = Rack::Utils.parse_nested_query(@env['QUERY_STRING'])
    requested_formats = params['format']&.split(',') || []

    formatter = TimeFormatter.new(requested_formats)

    if formatter.valid?
      response = Rack::Response.new(formatter.formatted_time, 200, headers)
    else
      response = Rack::Response.new("Unknown time format [#{formatter.invalid_formats.join(', ')}]", 400, headers)
    end

    response.finish
  end
end
