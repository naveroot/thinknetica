require_relative 'instance_counter'
class Route
  include InstanceCounter
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    instances_counter_up
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station
    if @stations.size < 3
      puts 'no middle stations'
    else
      puts 'Выберите станцию для удаления:'
      middle_station_list
      station_id = gets.chomp.to_i
      @stations.delete_at(station_id + 1)
      puts 'Станция удалена'
    end
  end

  def middle_station_list
    @stations[1...@stations.size - 1].each_with_index {|station, index| puts "[#{index}] #{station.name}"}
  end

  def all_station_list
    @stations.each_with_index {|station, index| puts "[#{index}] #{station.name}"}
  end
end
