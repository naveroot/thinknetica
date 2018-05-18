require_relative '../ls2_oop_in_ruby_short/route'
require_relative '../ls2_oop_in_ruby_short/station'
require_relative '../ls2_oop_in_ruby_short/train'

class LessonOOP
  WAGON_TYPE = %w[CARGO PASSENGER].freeze

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @stations << Station.new('Moscow')
    @stations << Station.new('SPB')
    @stations << Station.new('Novgorod')
    @stations << Station.new('Tallin')
    @routes   << Route.new(@stations[0], @stations[1])
    @trains   << Train.new('CARGO', 9, '#12383490', @routes[0])
  end

  def station_list
    puts 'Список всех станций: '
    @stations.each_with_index { |station, index| puts "[#{index}] #{station.name}" }
    puts 'Выберите станцию:'
    @station_select_id = gets.chomp.to_i
  end

  def trains_list
    puts 'Список всех поездов: '
    @trains.each_with_index { |train, index| puts "[#{index}] #{train.number} #{train.type} #{train.wagons}" }
    puts 'Выберите поезд:'
    @train_select_id = gets.chomp.to_i
  end

  def routes_list
    puts 'Список всех маршрутов: '
    @routes.each_with_index { |route, index| puts "[#{index}] #{route.stations.first.name} - #{route.stations.last.name}" }
    puts 'Выберите маршрут:'
    @route_select_id = gets.chomp.to_i
  end

  def start
    stations_test
    route_test
    train_test
  end

  def train_test
    puts '========================'
    puts 'Train tests...'
    puts '========================'
    trains_list
    loop do
      case trains_menu_choice
      when 1
        puts 'Введите номер поезда:'
        number = gets.chomp
        puts 'Выберите тип поезда:'
        WAGON_TYPE.each_with_index {|type, index | puts "[#{index}] #{type}"}
        type = WAGON_TYPE[gets.chomp.to_i]
        puts 'Введите колличество вагонов:'
        wagons = gets.chomp.to_i
        puts 'Введите маршрут для поезда:'
        routes_list
        route = @routes[@route_select_id]
        @trains << Train.new(type, wagons, number, route)
        puts 'Поезд успешно добавлен'
        trains_list
      when 2
        @trains[@train_select_id].speed_up
      when 3
        @trains[@train_select_id].stop
      when 4
        @trains[@train_select_id].add_wagon
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
      end
    end
  end

  def route_test
    puts '========================'
    puts 'Route tests...'
    puts '========================'
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

  def stations_test
    puts '======================== '
    puts 'Station tests...'
    puts '======================== '
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
        @stations[@station_select_id].remove_train
      when 6
        station_list
      when 9
        break
      end
    end
  end

  def stations_menu_choice
    puts 'Выбраная станция: ' + @stations[@station_select_id].name.to_s
    puts 'Выберите действие: '
    puts '1. Создать станцию '
    puts '2. Добавить поезд на станцию '
    puts '3. Показать все поезда на станции '
    puts '4. Колличество поездов на станции по типу'
    puts '5. Удалить поезд со станции'
    puts '6. Выбрать другую станцию'
    puts '9. Переход к тестированию маршрутов'
    gets.chomp.to_i
  end

  def routes_menu_choice
    puts 'Выбраный маршрут: ' +
         @routes[@route_select_id].stations.first.name +
         ' - ' +
         @routes[@route_select_id].stations.last.name
    puts 'Выберите действие: '
    puts '1. Создать маршрут '
    puts '2. Добавить  промежуточную станцию '
    puts '3. Удалить промежуточную станцию '
    puts '4. Показать полный маршрут'
    puts '9. Переход к тестированию поездов'
    gets.chomp.to_i
  end

  def trains_menu_choice
    puts 'Выбраный поезд:'
    puts '========================='
    puts 'номер: ' + @trains[@train_select_id].number.to_s
    puts 'скорость: ' + @trains[@train_select_id].speed.to_s
    puts 'текущая станция: ' + @trains[@train_select_id].current_station.to_s
    puts 'число вагонов: ' + @trains[@train_select_id].wagons.to_s
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
    puts '10. Выход'
    gets.chomp.to_i
  end
end

lesson = LessonOOP.new
lesson.start

# # Train
# puts 'Train tests...'
# puts ' ======================== '
# train = Train.new(number: '098765',       # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
#                   type: 'PASSENGER',      # эти данные указываются при создании экземпляра класса
#                   wagons: 9)
# train.speed_up                            # Может набирать скорость
# train.current_speed                       # Может возвращать текущую скорость
# train.stop                                # Может тормозить (сбрасывать скорость до нуля)
# train.current_wagons                      # Может возвращать количество вагонов
# train.add_wagon                           # Может прицеплять/отцеплять вагоны
# train.remove_wagon
# train.add_route(route)                    # Может принимать маршрут следования (объект класса Route).
# train.current_station                     # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# train.go_next_station                     # Может перемещаться между станциями, указанными в маршруте.
# train.go_previous_station
# train.near_stations                       # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
