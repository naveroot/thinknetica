require_relative 'instance_counter'
class Route
  @@routes = []
  include InstanceCounter
  attr_accessor :stations, :first_station, :last_station

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
    raise 'Эта станция уже есть в маршруте' if @stations.include? station
    raise 'station must be Station' unless station.is_a? Station
    @stations.insert(-2, station)
  end

  def remove_station(station)
    raise 'Нет промежуточных станций' if @stations.size < 3
    raise 'В маршруте нет такой станции' unless @stations.include? station
    if [@first_station, @last_station].include?(station)
      raise 'Нельзя удалить начальную или конечную станцию маршрута'
    end
    @stations.delete(station)
  end

  def middle_stations
    @stations[1...@stations.size - 1]
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  def validate!
    error1 = 'Станцией назначения не может быть станция отправления'
    raise error1 if first_station == last_station
  end
end
