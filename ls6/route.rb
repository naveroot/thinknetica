require_relative 'instance_counter'
class Route
  @@routes = []
  include InstanceCounter
  attr_accessor :stations

  def self.all
    @@routes
  end

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @first_station = first_station
    @last_station = last_station
    validate!
    @@routes << self
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise 'Станцией назначения не может быть станция отправления' if @first_station == @last_station
  end
end
