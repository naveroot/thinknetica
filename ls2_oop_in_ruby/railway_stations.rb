class RailwayStations
  attr_reader :railway_stations
  def initialize
    @railway_stations = []
  end

  def make_station
    names_array = []
    print 'Введите название станции: '
    name = gets.chomp
    puts 'Выберите соседние станции через запятую:'
    if @railway_stations.empty?
      puts 'Список станций пуст'
    else
      stations_names
      near_stations = gets.chomp
      near_stations = near_stations.split(/,/).map(&:to_i)
      near_stations.each do |index|
        names_array << @railway_stations[index].name
        @railway_stations[index].add_near_station(name)
      end
    end
    @railway_stations << RailwayStation.new(name: name,
                                            near_stations: names_array)
  end

  def add_station(station)
    @railway_stations << station
  end

  def stations_names
    @railway_stations.each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end
  end
end

