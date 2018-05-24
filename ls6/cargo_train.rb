require_relative 'cargo_wagon'
class CargoTrain < Train
  attr_reader :type

  def initialize(name)
    @type = :cargo
    super(name)
  end

  protected

  def validate!
    raise 'Тип поезда не соответствует классу' if type != :cargo
    super
  end
end
