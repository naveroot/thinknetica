class Routes
  def initialize
    @routes = []
  end

  def add_route(route)
    @routes << route
  end
  def make_route(railway_stations)
    @railway_stations = railway_stations
    @route = Route.new
    select_first_station #TODO Доделать цикл и выход из него
    select_next_stations
    select_next_stations
    select_next_stations
    route_created
    @routes << @route
  end

  def show_routes
    @routes.each_with_index do |route, index|
      puts "#{index}  #{route.stations.first} - #{route.stations.last}"
    end
  end


  def change_route
    puts 'Выберите маршрут'
    show_routes
    route_id = gets.chomp.to_i
    puts "Выберите действие:"
    puts "0. Удалить станцию из маршрута"
    puts "1. Добавить станцию в маршрут"
    choice = gets.chomp.to_i
    case choice
    when 0
      @routes[route_id].delete_station
    when 1
      @route = @routes[route_id]
      select_next_stations
      route_created
    end
  end

    private

  def select_first_station
    puts 'Выберите начальную станцию маршрута (номер):'
    @railway_stations.each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end
    station_id = gets.chomp.to_i
    @route.add_station(@railway_stations[station_id].name)
  end

  def select_next_stations
    last_station = @railway_stations.select { |station| station.name == @route.stations.last }
    puts 'Выберите следующую станцию'
    last_station[0].near_stations.each_with_index do |station, index|
      puts "#{index}. #{station}"
    end
    station_id = gets.chomp.to_i
    @route.add_station(last_station[0].near_stations[station_id])
  end

  def route_created
    puts '***Маршрут успешно сохранен****'
    @route.stations.each do |station|
      print " - #{station} -"
    end
    puts
  end
end
