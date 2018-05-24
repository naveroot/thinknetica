module InterfaceGUI
  TRAIN_TYPE = [CargoTrain, PassengerTrain].freeze # так делать можно?

  private

  def protected_prompt(size)
    @size = size
    puts 'Выберите номер:'
    loop do
      @choice = gets.chomp.to_i
      break if @choice.between?(0, @size - 1)
      puts "неверный номер. выберите номер от 0 до  #{@size - 1}"
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
    if @stations.empty?
      puts 'В списке нет станций'
      new_station
    else
      puts 'Список всех станций: '
      @stations.each_with_index {|station, index| puts "[#{index}] #{station.name}"}
      @station_select_id = protected_prompt(@stations.size)
    end
  end

  def trains_list
    if @trains.empty?
      puts 'В списке нет поездов'
      new_train
      @train_select_id = @trains.size - 1
    else
      puts 'Список всех поездов: '
      @trains.each_with_index {|train, index| puts "[#{index}] #{train.class} #{train.number} #{train.wagons.size}"}
      @train_select_id = protected_prompt(@trains.size)
    end
  end

  def routes_list
    if @routes.empty?
      puts 'В списке нет маршрутов'
      new_route
    else
      puts 'Список всех маршрутов: '
      @routes.each_with_index {|route, index| puts "[#{index}] #{route.stations.first.name} - #{route.stations.last.name}"}
    end
  end

  def new_route
    puts '==========================='
    puts 'Создаем новый маршрут'
    puts '==========================='
    if @stations.size < 2
      puts 'Что бы создать маршрут должно быть минимум 2 станции'
      new_station while @stations.size < 2
    end
    puts 'Выберите станцию отправления:'
    station_list
    first_station = @stations[@station_select_id]
    puts 'Выберите конечную станцию:'
    station_list
    last_station = @stations[@station_select_id]
    @routes << Route.new(first_station, last_station)
    @route_select_id = @routes.size - 1
  end

  def new_train
    puts '==========================='
    puts 'Создаем новый поезд'
    puts '==========================='
    loop do
      puts 'Введите номер поезда:'
      @number = gets.chomp
      break if valid_train_number?(@number)
      puts 'Поезд с таким номером уже существует'
    end
    puts 'Выберите тип поезда:'
    TRAIN_TYPE.each_with_index {|type, index| puts "[#{index}] #{type}"}
    choice = protected_prompt(TRAIN_TYPE.size)
    train_type = TRAIN_TYPE[choice]
    @trains << TrainFactory.build(number: @number, type: train_type)
    @train_select_id = @trains.size - 1
  end

  # def train_near_stations(near_stations)
  #   previous_station = if near_stations[:previous_station].nil?
  #                        'Поезд на конечной станции'
  #                      else
  #                        near_stations[:previous_station].name
  #                      end
  #   next_station = if near_stations[:next_station].nil?
  #                    'Поезд на конечной станции'
  #                  else
  #                    near_stations[:next_station].name
  #                  end
  #   puts 'Предыдущая станция:' + previous_station.to_s
  #   puts 'Следующая станция:' + next_station.to_s
  # end

  def new_station
    puts '==========================='
    puts 'Создаем новую станцию'
    puts '==========================='
    loop do
      puts 'Введите название станции'
      @station_name = gets.chomp
      break if valid_station_name?(@station_name)
      puts 'Неверное название станции. Название не моет быть пустым, либо станция уже создана'
    end
    @stations << Station.new(@station_name)
    @station_select_id = @stations.size - 1
  end

  def valid_station_name?(station_name)
    !(@stations.map(&:name).include?(station_name) || station_name == '')
  end

  def valid_train_number?(train_name)
    !@trains.map(&:number).include?(train_name)
  end
end
