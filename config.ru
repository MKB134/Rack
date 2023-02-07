require_relative 'app'
require_relative 'time_formatter'

ROUTES = {
  '/time' => App.new
}


run Rack::URLMap.new(ROUTES)
run App.new
