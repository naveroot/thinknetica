# Имеет начальную и конечную станцию, а также список промежуточных станций
# Может добавлять станцию в список
# Может удалять станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_accessor :stations, :last_station, :first_station,
                :full_route
  def initialize(args = {})
    args = defaults.merge(args)
    @first_station = args[:first_station]
    @last_station = args[:last_station]
    @stations = []
    @full_route = []
    add_to_full
  end

  def defaults
    {first_station: 'MSK', last_station: 'SPB' }
  end

  def add_station(station)
    @stations << station
    add_to_full
  end

  def remove_station
    puts 'Выберите станцию для удаления:'
    @stations.each_with_index { |station, index| puts "#{index}| #{station}"}
    station_id = gets.chomp.to_i
    @stations.delete_at(station_id)
    puts "Станция удалена"
  end

  def station_list
    puts @first_station
    @stations.each { |station| puts station }
    puts @last_station
  end

  private

  def add_to_full
    @full_route = [@first_station, *@stations, @last_station]
  end
end
