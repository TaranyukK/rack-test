class Time
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/time'
      params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
      requested_formats = params['format']&.split(',') || []

      formatter = TimeFormatter.new(requested_formats)
      formatter.call
      if formatter.valid?
        respond(200, formatter.time_string, env)
      else
        respond(400, formatter.invalid_string, env)
      end
    else
      respond(404, 'Not Found', env)
    end
  end

  private

  def respond(status, body, env)
    _status, headers, _body = @app.call(env)
    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end
