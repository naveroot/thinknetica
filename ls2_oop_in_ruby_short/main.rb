require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

class LessonOOP
  WAGON_TYPE = [CargoTrain, PassengerTrain].freeze  # так делать можно?

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def start
    #seed
    main_menu
  end

  private #не должнобыть доступно извне

  def seed
    @stations << Station.new('Moscow')
    @stations << Station.new('SPB')
    @stations << Station.new('Novgorod')
    @stations << Station.new('Tallin')
    @routes   << Route.new(@stations[0], @stations[1])
    @routes   << Route.new(@stations[1], @stations[2])
    @trains   << CargoTrain.new('0123123', @routes[0])
    @trains   << PassengerTrain.new('3456785', @routes[0])
  end

  def station_list
    puts 'Список всех станций: '
    @stations.each_with_index { |station, index| puts "[#{index}] #{station.name}" }
    puts 'Выберите станцию:'
    @station_select_id = gets.chomp.to_i
  end

  def trains_list
    puts 'Список всех поездов: '
    @trains.each_with_index { |train, index| puts "[#{index}] #{train.type} #{train.number} #{train.wagons.size}" }
    puts 'Выберите поезд:'
    @train_select_id = gets.chomp.to_i
  end

  def routes_list
    puts 'Список всех маршрутов: '
    @routes.each_with_index { |route, index| puts "[#{index}] #{route.stations.first.name} - #{route.stations.last.name}" }
    puts 'Выберите маршрут:'
    @route_select_id = gets.chomp.to_i
  end


  def main_menu
    loop do
      case main_menu_choice
      when 1
        stations_menu
      when 2
        route_menu
      when 3
        train_menu
      when 9
        break
      end
    end
  end

  def train_menu
    trains_list
    loop do
      case trains_menu_choice
      when 1
        puts 'Введите номер поезда:'
        number = gets.chomp
        puts 'Выберите тип поезда:'
        WAGON_TYPE.each_with_index {|type, index | puts "[#{index}] #{type}"}
        train_type = WAGON_TYPE[gets.chomp.to_i]
        # puts 'Введите колличество вагонов:'
        # wagons = gets.chomp.to_i
        puts 'Введите маршрут для поезда:'
        routes_list
        route = @routes[@route_select_id]
        @trains << train_type.new(number, route)
        puts 'Поезд успешно добавлен'
        trains_list
      when 2
        @trains[@train_select_id].speed_up
      when 3
        @trains[@train_select_id].stop
      when 4
        # А вот почему тут в ТЗ нужно именно в параметре. Тут же как-раз
        # утиная типизация может быть? у обоих классов есть метод, в них и разделить?
        @trains[@train_select_id].add_wagon(@trains[@train_select_id].cargo? ? CargoWagon.new : PassengerWagon.new)
      when 5
        @trains[@train_select_id].remove_wagon
      when 6
        routes_list
        @trains[@train_select_id].add_route(@routes[@route_select_id])
      when 7
        @trains[@train_select_id].go_next_station
      when 8
        @trains[@train_select_id].go_previous_station
      when 9
        near_stations = @trains[@train_select_id].near_stations
        previous_station = if near_stations[:previous_station].nil?
                             'Поезд на конечной станции'
                           else
                             near_stations[:previous_station].name
                           end
        next_station = if near_stations[:nexn_station].nil?
                         'Поезд на конечной станции'
                       else
                         near_stations[:next_station].name
                       end
        puts 'Предыдущая станция:' + previous_station.to_s
        puts 'Следующая станция:' + next_station.to_s
      when 10
        break
      end
    end
  end

  def route_menu
    routes_list
    loop do
      case routes_menu_choice
      when 1
        puts 'Выберите станцию отправления:'
        station_list
        first_station = @stations[@station_select_id]
        puts 'Выберите конечную станцию:'
        station_list
        last_station = @stations[@station_select_id]
        @routes << Route.new(first_station, last_station)
        routes_list
      when 2
        puts 'Выберите станцию для добавления:'
        station_list
        @routes[@route_select_id].add_station(@stations[@station_select_id])
      when 3
        @routes[@route_select_id].remove_station
      when 4
        @routes[@route_select_id].all_station_list
      when 9
        break
      end

    end
  end

  def stations_menu
    station_list
    loop do
      case stations_menu_choice
      when 1
        puts 'Введите название станции'
        station_name = gets.chomp
        @stations << Station.new(station_name)
        station_list
      when 2
        trains_list
        @stations[@station_select_id].add_train(@trains[@train_select_id])
      when 3
        p '======================== '
        @stations[@station_select_id].show_trains
        p '======================== '
      when 4
        p '======================== '
        @stations[@station_select_id].show_train_types
        p '======================== '
      when 5
        @stations[@station_select_id].show_remove_train
      when 6
        station_list
      when 9
        break
      end
    end
  end

  def main_menu_choice
    puts '========================'
    puts 'Главное меню'
    puts '========================'
    puts '1. Управление станциями'
    puts '2. Управление маршрутами'
    puts '3. Управление поездами'
    puts '9. Для выхода'
    puts 'Выберите действие: '
    gets.chomp.to_i
  end

  def stations_menu_choice
    puts '======================== '
    puts 'Меню управления станциями'
    puts '======================== '
    puts 'Выбраная станция: ' + @stations[@station_select_id].name.to_s
    puts 'Число поездов на станции: ' + @stations[@station_select_id].trains.size.to_s
    puts 'Выберите действие: '
    puts '1. Создать станцию '
    puts '2. Добавить поезд на станцию '
    puts '3. Показать все поезда на станции '
    puts '4. Колличество поездов на станции по типу'
    puts '5. Удалить поезд со станции'
    puts '6. Выбрать другую станцию'
    puts '9. Выход в главное меню'
    gets.chomp.to_i
  end

  def routes_menu_choice
    puts '========================'
    puts 'Меню управления маршрутами'
    puts '========================'
    puts 'Выбраный маршрут: ' +
         @routes[@route_select_id].stations.first.name +
         ' - ' +
         @routes[@route_select_id].stations.last.name
    puts 'Выберите действие: '
    puts '1. Создать маршрут '
    puts '2. Добавить  промежуточную станцию '
    puts '3. Удалить промежуточную станцию '
    puts '4. Показать полный маршрут'
    puts '9. Выход в главное меню'
    gets.chomp.to_i
  end

  def trains_menu_choice
    puts '========================'
    puts 'Меню управления поездами'
    puts '========================'
    puts 'Выбраный поезд:'
    puts '========================='
    puts 'номер: ' + @trains[@train_select_id].number.to_s
    puts 'скорость: ' + @trains[@train_select_id].speed.to_s
    puts 'текущая станция: ' + @trains[@train_select_id].current_station.to_s
    puts 'число вагонов: ' + @trains[@train_select_id].wagons.size.to_s
    puts '========================='
    puts 'Выберите действие: '
    puts '1. Создать поезд'
    puts '2. Набрать скорость'
    puts '3. Остановить поезд'
    puts '4. Прицепить вагон'
    puts '5. Отцепить вагон'
    puts '6. Добавить маршрут следования'
    puts '7. Ехать к следующей станции'
    puts '8. Ехать к предыдущей станции'
    puts '9. Посмотреть соседние станции'
    puts '10.Выход в главное меню'
    gets.chomp.to_i
  end
end

lesson = LessonOOP.new
lesson.start