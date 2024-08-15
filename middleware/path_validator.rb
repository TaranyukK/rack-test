class PathValidator
  VALID_PATHS = %w[/time].freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    if valid_path?(env['PATH_INFO'])
      @app.call(env)
    else
      [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
    end
  end

  private

  def valid_path?(path)
    VALID_PATHS.include?(path)
  end
end
