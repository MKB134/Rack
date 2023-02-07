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
    @valid = []
    format_time
  end

  def valid?
    invalid_args.empty?
  end

  def response_time
    Time.now.strftime(@valid.join('-'))
  end


  def format_time
    @requested_format.each do |format|
      if VALID_FORMAT[format.to_sym]
        @valid << VALID_FORMAT[format.to_sym]
      else
        @invalid_args << format
      end
    end
  end
end
