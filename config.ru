require_relative 'middleware/time'
require_relative 'time_formatter'
require_relative 'app'

use Time
run App.new
