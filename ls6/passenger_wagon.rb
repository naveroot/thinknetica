class PassengerWagon < Wagon
  attr_reader :type

  def initialize
    @type = :passenger
    validate!
  end

  protected

  def validate!
    raise 'Тип вагона не соответствует классу' if type != :passenger
    true
  end
end