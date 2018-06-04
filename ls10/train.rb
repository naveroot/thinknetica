require_relative 'vendor_info'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  extend Accessors
  include Validation
  include VendorInfo
  include InstanceCounter
  attr_reader :wagons, :speed, :route, :number

  attr_accessor_with_history :speed
  strong_attr_accessor :number, String

  @@trains = []
  REGEXP_VALIDATE = /^(\w|\d){3}-?(\w|\d){2}$/

  validate :number, :format, REGEXP_VALIDATE
  validate :number, :type, String
  validate :number, :presence
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
    error1 = 'Такого поезда не существует'
    raise error1 unless @@trains.map(&:number).include?(number)
    @@trains.select { |train| train.number == number }.first
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def current_station
    @route.stations[@current_station_id]
  end

  def each_wagon_in_train
    raise 'Нужно передать блок' unless block_given?
    @wagons.each { |wagon| yield(wagon) }
  end

  def go_next_station
    raise 'У поезда нет маршрута' if @route.nil?
    raise 'Конечная станция. Конец маршрута.' if @current_station_id >= @route.stations.size - 1
    remove_from_current_station
    @current_station_id += 1
    add_to_current_station
  end

  def go_previous_station
    raise 'У поезда нет маршрута' if @route.nil?
    raise puts 'Конечная станция. Конец маршрута.' if @current_station_id.zero?
    remove_from_current_station
    @current_station_id -= 1
    add_to_current_station
  end

  def near_stations
    raise 'У поезда нет маршрута' if @route.nil?
    if @current_station_id > 0
      previous_station = @route.stations[@current_station_id - 1]
    elsif @current_station_id < @route.stations.size - 1
      next_station = @route.stations[@current_station_id + 1]
    end
    { previous_station: previous_station, next_station: next_station }
  end

  def add_route(route)
    raise 'Маршрут должен бывть Route' unless route.is_a? Route
    remove_from_current_station unless @route.nil?
    @current_station_id = 0
    @route = route
    add_to_current_station
  end

  def add_wagon(wagon)
    raise 'Цеплять или отцеплять вагоны можно только при полной остановке' unless stop?
    raise 'Неверный тип вагона' unless @type == wagon.type
    @wagons << wagon
  end

  def remove_wagon
    raise 'Цеплять или отцеплять вагоны можно только при полной остановке' unless stop?
    raise 'У поезда нет вагонов' if @wagons.empty?
    @wagons.delete_at(-1)
  end

  # def valid?
  #   validate!
  # rescue StandardError
  #   false
  # end

  protected

  # def validate!
  #   raise 'Поезд с таким номером уже существует' if @@trains.map(&:number).include?(number)
  #   raise 'Номер поезда не соответствует заданным параметрам' if number !~ REGEXP_VALIDATE
  #   true
  # end

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
