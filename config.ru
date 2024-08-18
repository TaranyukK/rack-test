require_relative 'middleware/path_validator'
require_relative 'middleware/time'
require_relative 'time_formatter'
require_relative 'app'

use PathValidator
use Time
run App.new
