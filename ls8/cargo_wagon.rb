class CargoWagon < Wagon
  attr_reader :type, :occupied_volume, :volume, :name

  def initialize(name, volume)
    @type = :cargo
    @name = name
    @volume = volume
    @occupied_volume = 0
    validate!
  end

  def occupy_volume(volume)
    raise 'В вагоне не хватит места' if available_volume < volume
    @occupied_volume += volume
  end

  def available_volume
    @volume - @occupied_volume
  end

  protected

  def validate!
    raise 'Объем должен быть больше нуля' if volume < 0
    raise 'Тип вагона не соответствует классу' if type != :cargo
    true
  end
end
