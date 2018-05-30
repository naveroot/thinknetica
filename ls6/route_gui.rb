module RouteGUI
  def selected_route_info
    p @selected_route.stations
    puts 'Выбраный маршрут: ' +
             Route.all[@route_select_id].stations.first.name +
             ' - ' +
             Route.all[@route_select_id].stations.last.name
    puts 'Полный маршрут:'
    @selected_route.stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
  end

  def routes_menu_choice
    puts '========================'
    puts 'Меню управления маршрутами'
    puts '========================'
    selected_route_info unless @selected_route.nil?
    puts 'Выберите действие: '
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
    Route.all.each_with_index {|route, index| puts "[#{index}:  #{route.stations.first.name} - #{route.stations.last.name}"}
    @route_select_id = protected_prompt(Route.all.size)
    @selected_route = Station.all[@station_select_id]
  end

  def new_route
    puts '==========================='
    puts 'Создаем новый маршрут'
    puts '==========================='
    if Station.all.size < 2
      puts 'Что бы создать маршрут должно быть минимум 2 станции'
      new_station while Station.all.size < 2
    end
    puts 'Выберите станцию отправления:'
    select_station
    first_station = Station.all[@station_select_id]
    puts 'Выберите конечную станцию:'
    select_station
    last_station = Station.all[@station_select_id]
    @selected_route = Route.new(first_station, last_station)
    @route_select_id = Route.all.size - 1
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def add_station_to_route
    raise 'Станция не выбрана' if @selected_route.nil?
    raise 'Все станции уже есть в маршруте' if (Station.all - @selected_route.stations).empty?
    raise 'В системе нет ниодной станции' if Station.all.empty?
    puts 'Выберите станцию для добавления: '
    acceptable_stations = (Station.all - @selected_route.stations)
    acceptable_stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
    choice = gets.chomp.to_i
    raise 'Введите корректный номер станции' unless choice.between?(0, acceptable_stations.size - 1)
    @selected_route.add_station(acceptable_stations[choice])
  rescue RuntimeError => error
    puts error.message
  end

  def remove_station_from_route
    raise 'Станция не выбрана' if @selected_route.nil?
    raise 'Нет ниодной промежуточной станции' if @selected_route.middle_stations.empty?
    puts 'Выберите станцию для удаления: '
    acceptable_stations = @selected_route.middle_stations
    acceptable_stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
    choice = gets.chomp.to_i
    raise 'Введите корректный номер станции' unless choice.between?(0, acceptable_stations.size - 1)
    @selected_route.remove_station(acceptable_stations[choice])
  rescue RuntimeError => error
    puts error.message
  end
end
