module InterfaceGUI
  WAGON_TYPE = [CargoTrain, PassengerTrain].freeze  # так делать можно?

  def  protected_prompt(size)
    loop do
      puts 'Выберите номер:'
      @choice = gets.chomp.to_i
      break if @choice.between?(0, size - 1)
      puts "Ошибка! введите число от 0 до #{size - 1}"
    end
    @choice
  end

  def enter_correct_choice
    puts 'Введите корректное число!'
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

  def selected_train
    puts 'Выбраный поезд:'
    puts '========================='
    puts 'номер: ' + @trains[@train_select_id].number.to_s
    puts 'скорость: ' + @trains[@train_select_id].speed.to_s
    puts 'текущая станция: ' + if @trains[@train_select_id].route.nil?
                                 'нет маршрута'
                               else
                                 @trains[@train_select_id].current_station.to_s
                               end
    puts 'число вагонов: ' + @trains[@train_select_id].wagons.size.to_s
    puts '========================='
  end

  def trains_menu_choice
    puts '========================'
    puts 'Меню управления поездами'
    puts '========================'
    selected_train unless @trains.empty?
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

  def station_list
    begin
    raise if @stations.empty?
    puts 'Список всех станций: '
    @stations.each_with_index { |station, index| puts "[#{index}] #{station.name}" }
    @station_select_id = protected_prompt(@stations.size)
  rescue
    puts 'Нет ниодной станции! Создаем новую...'
    new_station
    retry
    end
  end

  def trains_list
    begin
    raise if @trains.empty?
    puts 'Список всех поездов: '
    @trains.each_with_index { |train, index| puts "[#{index}] #{train.class} #{train.number} #{train.wagons.size}" }
      @train_select_id = protected_prompt(@trains.size)
  rescue
    puts 'Нет ниодного поезда! Создаем новый...'
    @trains << TrainFactory.build(new_train)
    retry
    end
  end

  def routes_list
    begin
    raise if @routes.empty?
    puts 'Список всех маршрутов: '
    @routes.each_with_index { |route, index| puts "[#{index}] #{route.stations.first.name} - #{route.stations.last.name}" }
    @route_select_id = protected_prompt(@routes.size)
    rescue
      puts 'Нет ниодного маршрута! Создаем новый...'
      new_route
      retry
    end
  end

  def new_route
    puts '==========================='
    puts 'Создаем новый маршрут'
    puts '==========================='
    begin
      raise if @stations.size < 2
    puts 'Выберите станцию отправления:'
    station_list
    first_station = @stations[@station_select_id]
    puts 'Выберите конечную станцию:'
    station_list
    last_station = @stations[@station_select_id]
    @routes << Route.new(first_station, last_station)
    rescue
      puts 'Недостаточно станций для создания маршрута...'
      new_station
    end
  end

  def new_train
    puts '==========================='
    puts 'Создаем новый поезд'
    puts '==========================='
    begin
      puts 'Введите номер поезда:'
      number = gets.chomp.to_s
    raise if number == ''
    rescue
    puts 'Номер не может быть пустым'
    retry
    end

    begin
    puts 'Выберите тип поезда:'
    WAGON_TYPE.each_with_index {|type, index | puts "[#{index}] #{type}"}
    type = gets.chomp.to_i
    raise unless type.between?(0,WAGON_TYPE.size-1)
    train_type = WAGON_TYPE[type]
    rescue
      puts 'Выберите корректный номер!'
      retry
    end

    {number: number, type: train_type}
  end

  def train_near_stations(near_stations)
    previous_station = if near_stations[:previous_station].nil?
                         'Поезд на конечной станции'
                       else
                         near_stations[:previous_station].name
                       end
    next_station = if near_stations[:next_station].nil?
                     'Поезд на конечной станции'
                   else
                     near_stations[:next_station].name
                   end
    puts 'Предыдущая станция:' + previous_station.to_s
    puts 'Следующая станция:' + next_station.to_s
  end

  def new_station
    puts '==========================='
    puts 'Создаем новую станцию'
    puts '==========================='
    puts 'Введите название станции'
    station_name = gets.chomp
    raise if station_name == ''
    @stations << Station.new(station_name)
  rescue
    puts 'Название не может быть пустым!'
    retry
  end
end