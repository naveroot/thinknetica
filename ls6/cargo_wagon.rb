class CargoWagon < Wagon
  attr_reader :type

  def initialize
    @type = :cargo
    validate!
  end

  protected

  def validate!
    raise 'Тип вагона не соответствует классу' if type != :cargo
    true
  end
end
