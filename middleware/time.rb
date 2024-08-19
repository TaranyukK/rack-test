class Time
  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env

    if env['PATH_INFO'] == '/time'
      params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
      requested_formats = params['format']&.split(',') || []

      formatter = TimeFormatter.new(requested_formats)
      if formatter.errors.empty?
        respond(200, formatter.formatted_time, env)
      else
        respond(400, "Unknown time format [#{formatter.errors.join(', ')}]", env)
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
