require_relative 'time_formatter'

class App
  def call(env)
    req = Rack::Request.new(env)
    return wrong_path unless req.path_info == '/time'

    return no_format unless req.params['format']

    tf = TimeFormatter.new(req.params['format'])

    if tf.valid?
      return_time(tf)
    else
      invalid_format(tf.invalid_args)
    end
  end

  private

  def response(status, body)
    [status, { 'Content-Type' => 'text/plain' }, [body]]
  end

  def return_time(formatter)
    response(200, formatter.format_time + "\n")
  end

  def wrong_path
    response(404, "404\nNot found\n")
  end

  def no_format
    response(400, "404\nBad request - no format provided\n")
  end

  def invalid_format(errors)
    response(400, "Unknown time format #{errors}\n")
  end
end