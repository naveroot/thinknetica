require_relative 'instance_counter'
class Station
  include InstanceCounter
  @@stations = []
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    instances_counter_up
  end

  def self.all
    @@stations
  end

  def add_train(train)
    @trains << train
  end

  def show_remove_train
    if @trains.empty?
      puts 'На станции нет поездов'
    else
      puts 'Выберите индекс поезда, который хотите удалить: '
      show_trains
      number = gets.chomp.to_i
      @trains.delete_at(number)
      puts 'Поезд удален'
    end
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def show_trains
    if @trains.empty?
      p "There are no trains"
    else
      @trains.each_with_index do |train, index|
        puts "#{index} | Номер: #{train.number}"
        puts "  | Тип: #{train.class}"
        puts "  | Колличество вагонов: #{train.wagons.size}"
      end
    end
  end

  def show_train_types
    @cargo_trains_counter = 0
    @passenger_train_counter = 0
    @trains.each do |train|
      if train.class == CargoTrain
        @cargo_trains_counter += 1
      else
        @passenger_train_counter += 1
      end
    end
    puts "Число грузовых составов на станции #{@name}: #{@cargo_trains_counter}"
    puts "Число пассажирских составов на станции #{@name}: #{@passenger_train_counter}"
  end

  def valid?
    validate!
  rescue
    false9
  end

  protected

  def validate!
    raise 'Название не может быть пустым' if name == ''
    raise 'Станция с таким названием уже создана' if @@stations.map(&:name).include?(name)
    true
  end
end
