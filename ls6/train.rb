require_relative 'vendor_info'
require_relative 'instance_counter'

class Train
  @@trains = []
  REGEXP_VALIDATE = /^(\w|\d){3}-?(\w|\d){2}$/
  include VendorInfo
  include InstanceCounter
  attr_reader :wagons, :speed, :route, :number

  def self.all
    @@trains
  end

  def initialize(number)
    @wagons = []
    @number = number
    @speed = 0
    @route = nil
    validate!
    @@trains << self
    instances_counter_up
    train_created
  end

  def self.find(number)
    if @@trains.map(&:number).include?(number)
      @@trains.select {|train| train.number == number}.first
    end
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def current_station
    @route.stations[@current_station_id].name
  end

  def go_next_station
    if @route.nil?
      puts 'Сначала выберите маршрут'
    elsif @current_station_id >= @route.stations.size - 1
      puts 'Конечная станция. Конец маршрута.'
    else
      remove_from_current_station
      @current_station_id += 1
      puts "Едем в #{@route.stations[@current_station_id].name}"
      add_to_current_station
    end
  end

  def go_previous_station
    if @route.nil?
      puts 'Сначала выберите маршрут'
    elsif @current_station_id.zero?
      puts 'Конечная станция. Конец маршрута.'
    else
      remove_from_current_station
      @current_station_id -= 1
      puts "Едем в #{@route.stations[@current_station_id].name}"
      add_to_current_station
    end
  end

  def near_stations
    if @route.nil?
      puts 'Сначала выберите маршрут'
    else
      previous_station = if @current_station_id.zero?
                           'Поезд на конечной станции'
                         else
                           @route.stations[@current_station_id - 1].name
                         end
      next_station = if @current_station_id <= @route.stations.size - 2
                       @route.stations[@current_station_id + 1].name
                     else
                       'Поезд на конечной станции'
                     end
      puts 'Предыдущая станция:' + previous_station.to_s
      puts 'Следующая станция:' + next_station.to_s
    end
  end

  def add_route(route)
    remove_from_current_station unless @route.nil?
    @current_station_id = 0
    @route = route
    add_to_current_station
  end

  def add_wagon(wagon)
    if stop?
      if @type == wagon.type
        @wagons << wagon
      else
        puts 'Неверный тип вагона'
      end
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  def remove_wagon
    if @wagons.empty?
      puts 'У поезда нет вагонов'
    elsif stop?
      @wagons.delete_at(-1)
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  protected # Используется только внутри класса

  def validate!
    puts @@trains.map(&:number)
    puts number
    raise 'Поезд с таким номером уже существует' if @@trains.map(&:number).include?(number)
    raise 'Номер поезда не соответствует заданным параметрам' if number !~ REGEXP_VALIDATE
    true
  end

  def train_created
    puts "Поезд типа #{self.class} под номером #{@number} успешно добавлен"
  end

  def add_to_current_station
    @route.stations[@current_station_id].add_train(self)
  end

  def remove_from_current_station
    @route.stations[@current_station_id].remove_train(self)
  end

  def stop?
    @speed.zero?
  end
end
