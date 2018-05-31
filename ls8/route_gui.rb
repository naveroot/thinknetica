module RouteGUI
  def selected_route_info
    puts 'Выбраный маршрут: ' +
             Route.all[@route_select_id].stations.first.name +
             ' - ' +
             Route.all[@route_select_id].stations.last.name
    full_route
  end

  def full_route
    puts 'Полный маршрут:'
    @selected_route.stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
  end

  def routes_menu_choice
    puts 'Меню управления маршрутами'
    selected_route_info unless @selected_route.nil?
    puts '0. Выбрать другой маршрут '
    puts '1. Создать маршрут '
    unless @selected_route.nil?
      puts '2. Добавить  промежуточную станцию '
      puts '3. Удалить промежуточную станцию '
    end
    puts '9. Выход в главное меню'
    gets.chomp.to_i
  end

  def select_route
    raise 'В списке нет маршрутов' if Route.all.empty?
    puts 'Список всех маршрутов: '
    routes_list
    @route_select_id = protected_prompt(Route.all.size)
    @selected_route = Station.all[@station_select_id]
  end

  def routes_list
    Route.all.each_with_index do |route, index|
      puts "#{index}:#{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

  def new_route
    error1 = 'Что бы создать маршрут должно быть минимум 2 станции'
    puts '!!!Создаем новый маршрут!!!'
    raise error1 if Station.all.size < 2
    first_station = choose_first_station
    last_station = choose_last_station
    @selected_route = Route.new(first_station, last_station)
    @route_select_id = Route.all.size - 1
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def choose_last_station
    puts 'Выберите конечную станцию:'
    select_station
    Station.all[@station_select_id]
  end

  def choose_first_station
    puts 'Выберите станцию отправления:'
    select_station
    Station.all[@station_select_id]
  end

  def validate_station_to_route
    error1 = 'Станция не выбрана'
    error2 = 'Все станции уже есть в маршруте'
    error3 = 'В системе нет ниодной станции'
    raise error1 if @selected_route.nil?
    raise error2 if (Station.all - @selected_route.stations).empty?
    raise error3 if Station.all.empty?
  end

  def select_add_station
    acceptable_stations = (Station.all - @selected_route.stations)
    acceptable_stations.each_with_index {|station, index| puts "#{index}: #{station.name}"}
    choice = gets.chomp.to_i
    error1 = 'Введите корректный номер станции'
    raise error1 unless choice.between?(0, acceptable_stations.size - 1)
    acceptable_stations[choice]
  end

  def add_station_to_route
    validate_station_to_route
    puts 'Выберите станцию для добавления: '
    @selected_route.add_station(select_add_station)
  rescue RuntimeError => error
    puts error.message
  end

  def validate_remove_station
    error1 = 'Станция не выбрана'
    error2 = 'Нет ниодной промежуточной станции'
    raise error1 if @selected_route.nil?
    raise error2 if @selected_route.middle_stations.empty?
  end

  def select_remove_station
    error1 = 'Введите корректный номер станции'
    acceptable_stations = @selected_route.middle_stations
    acceptable_stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
    choice = gets.chomp.to_i
    raise error1 unless choice.between?(0, acceptable_stations.size - 1)
    acceptable_stations[choice]
  end

  def remove_station_from_route
    validate_remove_station
    puts 'Выберите станцию для удаления: '
    @selected_route.remove_station(select_remove_station)
  rescue RuntimeError => error
    puts error.message
  end
end
