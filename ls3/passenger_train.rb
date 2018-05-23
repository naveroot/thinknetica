require_relative 'passenger_wagon'
class PassengerTrain < Train
  attr_reader :type

  def initialize(name)
    @type = :passenger
    super(name)
  end
end
