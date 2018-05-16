# Имеет начальную и конечную станцию, а также список промежуточных станций
# Может добавлять станцию в список
# Может удалять станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_accessor :stations
  def initialize
    @stations = []
  end

  def add_station(station)
    @stations << station
  end
end