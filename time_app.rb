class TimeApp
  def call(env)
    params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    requested_formats = params['format']&.split(',') || []

    formatter = TimeFormatter.new(requested_formats).call
    if formatter.valid?
      respond(200, formatter.time_string, env)
    else
      respond(400, formatter.invalid_string, env)
    end
  end

  private

  def respond(status, body, _env)
    response = Rack::Response.new(body, status)

    response.finish
  end
end
