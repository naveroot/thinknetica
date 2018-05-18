# Имеет название, которое указывается при ее создании
# Может принимать поезда
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  @@station_counter = 0
  attr_reader :name
  attr_accessor :trains, :near_stations

  def initialize(args = {})
    args = defaults.merge(args)
    @name = args[:name]
    @trains = []
    @near_stations = args[:near_stations]
  end

  def defaults
    @@station_counter += 1
    { name: "Station_#{@@station_counter}", near_stations: [] }
  end

  def add_train(train)
    @trains << train
  end

  def remove_train
    puts 'Выберите номер поезда, который хотите удалить: '
    show_trains
    number = gets.chomp
    @trains.delete_at(number)
    puts 'Поезд удален'
  end

  def show_trains
    @trains.each_with_index do |index, train|
      puts "#{index}. Тип: #{train.type} Колличество вагонов: #{train.wagons}"
    end
  end

  def add_near_station(name)
    @near_stations << name
  end
end