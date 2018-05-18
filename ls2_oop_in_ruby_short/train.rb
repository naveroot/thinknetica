# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
# эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  WAGON_TYPE = %w[CARGO PASSENGER].freeze
  @@number_counter = 0
  attr_reader :wagons, :speed, :type, :number

  def initialize(type, wagons, number, route)
    @type = type
    @wagons = wagons
    @number = number
    add_route(route)
    @speed = 0
  end

  def speed_up
    @speed += 10
    current_speed
  end

  def stop
    @speed = 0
    current_speed
  end

  def current_speed
    puts "Скорость поезда: #{@speed}"
  end

  def current_wagons
    puts "Колличество вагонов: #{@wagons}"
  end

  def current_station
    @route.stations[@current_station_id].name
  end

  def go_next_station
    if @current_station_id >= @route.stations.size - 1
      puts 'Конечная станция. Конец маршрута.'
    else
      @current_station_id += 1
      puts "Едем в #{@route.stations[@current_station_id]}"
    end
  end

  def go_previous_station
    if @current_station_id.zero?
      puts 'Конечная станция. Конец маршрута.'
    else
      @current_station_id -= 1
      puts "Едем в #{@route.stations[@current_station_id]}"
    end
  end

  def near_stations
    near_stations = {}
    near_stations[:previous_station] = @route.stations[@current_station_id - 1] if @current_station_id > 0
    near_stations[:next_station] = @route.stations[@current_station_id + 1] if @current_station_id >= @route.stations.size - 1
    return near_stations
  end

  def add_wagon
    if stop?
      @wagons += 1
      current_wagons
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  def remove_wagon
    if stop?
      @wagons -= 1
      current_wagons
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  def add_route(route)
    @current_station_id = 0
    @route = route
  end

  private

  def stop?
    @speed.zero?
  end
end
