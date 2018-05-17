require_relative '../ls2_oop_in_ruby_short/route'
require_relative '../ls2_oop_in_ruby_short/station'
require_relative '../ls2_oop_in_ruby_short/train'

# Station
puts 'Station tests...'
puts '======================== '
puts 'Введите название станции:'
station_name = gets.chomp                 # Имеет название, которое указывается при ее создании
station = Station.new(name: station_name) # Без параметров название создается автоматически
station.add_train(Train.new)              # Может принимать поезда (по одному за раз)
puts '======================== '
station.show_trains                       # Может возвращать список всех поездов на станции, находящиеся в текущий момент
puts '======================== '
station.show_train_types                  # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
puts '======================== '
station.remove_train                      # Может отправлять поезда (по одному за раз, при этом,
                                          # поезд удаляется из списка поездов, находящихся на станции).

# Route
puts 'Route tests...'
puts ' ======================== '
route = Route.new(first_station: 'SPB',   # Имеет начальную и конечную станцию, а также список промежуточных станций.
                  last_station: 'MSK')    # Начальная и конечная станции указываютсся при создании маршрута,
                                          # а промежуточные могут добавляться между ними.
route.add_station('Kolpino')              # Может добавлять промежуточную станцию в список
route.remove_station                      # Может удалять промежуточную станцию из списка
puts '======================== '
route.station_list                        # Может выводить список всех станций по-порядку от начальной до конечной
route.add_station('Kolpino')

# Train
puts 'Train tests...'
puts ' ======================== '
train = Train.new(number: '098765',       # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
                  type: 'PASSENGER',      # эти данные указываются при создании экземпляра класса
                  wagons: 9)
train.speed_up                            # Может набирать скорость
train.current_speed                       # Может возвращать текущую скорость
train.stop                                # Может тормозить (сбрасывать скорость до нуля)
train.current_wagons                      # Может возвращать количество вагонов
train.add_wagon                           # Может прицеплять/отцеплять вагоны
train.remove_wagon
train.add_route(route)                    # Может принимать маршрут следования (объект класса Route).
train.current_station                     # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
train.go_next_station                     # Может перемещаться между станциями, указанными в маршруте.
train.go_previous_station
train.near_stations                       # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
