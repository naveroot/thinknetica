# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station
  @@station_counter = 0
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_remove_train
    puts 'Выберите индекс поезда, который хотите удалить: '
    show_trains
    number = gets.chomp.to_i
    @trains.delete_at(number)
    puts 'Поезд удален'
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
        puts "  | Тип: #{train.type}"
        puts "  | Колличество вагонов: #{train.wagons}"
      end
    end
  end

  def show_train_types
    @cargo_trains_counter = 0
    @passenger_train_counter = 0
    @trains.each do |train|
      if train.type == 'CARGO'
        @cargo_trains_counter += 1
      else
        @passenger_train_counter += 1
      end
    end
    puts "Число грузовых составов на станции #{@name}: #{@cargo_trains_counter}"
    puts "Число пассажирских составов на станции #{@name}: #{@passenger_train_counter}"
  end
end
