require_relative 'passenger_wagon'
class PassengerTrain < Train
  attr_reader :type

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
