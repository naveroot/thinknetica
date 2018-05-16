# Имеет начальную и конечную станцию, а также список промежуточных станций
# Может добавлять станцию в список
# Может удалять станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_accessor :stations
  def initialize(stations = [])
    @stations = stations
  end

  def add_station(station)
    @stations << station
  end

  def delete_station
    puts 'Выберите станцию для добавления:'
    show_stations
    station_id = gets.chomp.to_i
    @stations.delete!(@stations[station_id])
  end

  private

  def show_stations
    @stations.each_with_index do |station, index|
      puts "#{index}. #{station}"
    end
  end
end