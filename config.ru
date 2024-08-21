require_relative 'time_formatter'
require_relative 'time_app'

ROUTES = {
  '/time' => TimeApp.new
}

use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(ROUTES)
