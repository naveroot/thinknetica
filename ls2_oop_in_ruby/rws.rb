require_relative 'railway_station'
require_relative 'route'
require_relative 'train'
require_relative 'railway_stations'
require_relative 'routes'

railway_stations = RailwayStations.new
routes = Routes.new

railway_stations.add_station(RailwayStation.new(name: 'Moscow', near_stations: ['SPB']))
railway_stations.add_station(RailwayStation.new(name: 'SPB', near_stations: ['Moscow', 'EKB']))
railway_stations.add_station(RailwayStation.new(name: 'EKB', near_stations: ['SPB']))
routes.add_route(Route.new(['Moscow','SPB']))
routes.add_route(Route.new(['Moscow','SPB', 'EKB']))
loop do
  puts 'rws'
  puts 'menu'
  puts '======================'
  puts '1. create stations'
  puts '2. show stations'
  puts '3. create routes'
  puts '4. show routes'
  puts '5. change route'
  puts '9. exit'
  puts '======================'
  choice = gets.chomp.to_i

  case choice
  when 1
    railway_stations.make_station
    puts 'press any key...'
    gets
  when 2
    railway_stations.stations_names
    puts 'press any key...'
    gets
  when 3
    routes.make_route(railway_stations.railway_stations)
    puts 'press any key...'
    gets
  when 4
    routes.show_routes
    puts 'press any key...'
    gets
  when 5
    routes.change_route
  when 9
    break
  end
end

