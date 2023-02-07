require_relative 'time_formatter'

class App
  def call(env)
    req = Rack::Request.new(env)
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
    response(200, formatter.response_time + "\n")
  end

  def invalid_format(errors)
    response(400, "Unknown time format #{errors}\n")
  end
end