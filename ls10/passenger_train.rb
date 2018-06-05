require_relative 'passenger_wagon'
require_relative 'accessors'
require_relative 'validation'

class PassengerTrain < Train
  extend Accessors
  include Validation
  attr_reader :type
  validate :number, :format, REGEXP_VALIDATE
  validate :number, :type, String
  validate :number, :presence

  def initialize(name)
    @type = :passenger
    super(name)
  end

  protected

  def validate!
    raise 'Тип поезда не соответствует классу' if type != :passenger
    super
  end
end
