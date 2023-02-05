class TimeFormatter
  VALID_FORMAT = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :invalid_args, :requested_format

  def initialize(format)
    @requested_format = format.split(',')
    @invalid_args = []
    validate!
  end

  def valid?
    invalid_args.empty?
  end

  def format_time
    directive = requested_format.map { |f| VALID_FORMAT[f.to_sym] }
    Time.now.strftime(directive.join('-'))
  end

  private

  def validate!
    @invalid_args = requested_format.reject { |f| VALID_FORMAT.key?(f.to_sym) }
  end
end