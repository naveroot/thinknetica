class Train
  WAGON_TYPE = %w[CARGO PASSENGER].freeze
  attr_reader :wagons, :speed, :route, :number

  def initialize(number)
    @wagons = []
    @number = number
    @speed = 0
    @route = nil
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
    puts "Колличество вагонов: #{@wagons.size}"
  end

  def current_station
    @route.stations[@current_station_id].name
  end

  def go_next_station
    raise if @route.nil?
    if @current_station_id >= @route.stations.size - 1
      puts 'Конечная станция. Конец маршрута.'
    else
      remove_from_current_station
      @current_station_id += 1
      puts "Едем в #{@route.stations[@current_station_id].name}"
      add_to_current_station
    end
  rescue
    puts 'Сначала выберите маршрут'
  end

  def go_previous_station
    raise if @route.nil?
    if @current_station_id.zero?
      puts 'Конечная станция. Конец маршрута.'
    else
      remove_from_current_station
      @current_station_id -= 1
      puts "Едем в #{@route.stations[@current_station_id].name}"
      add_to_current_station
    end
  rescue
    puts 'Сначала выберите маршрут'
  end

  def near_stations
    raise if @route.nil?
    near_stations = {}
    near_stations[:previous_station] = @route.stations[@current_station_id - 1] if @current_station_id > 0
    near_stations[:next_station] = @route.stations[@current_station_id + 1] if @current_station_id >= @route.stations.size - 1
    return near_stations
  rescue
    puts 'Сначала выберите маршрут'
  end


  def add_route(route)
    remove_from_current_station unless @route.nil?
    @current_station_id = 0
    @route = route
    add_to_current_station
  end

  def add_wagon(wagon)
    if stop?
      @wagons << wagon
      current_wagons
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  def remove_wagon
    if stop?
      @wagons = @wagons.delete_at(-1)
      current_wagons
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  private #Используется только внутри класса

  def add_to_current_station
    @route.stations[@current_station_id].add_train(self)
  end

  def remove_from_current_station
    @route.stations[@current_station_id].remove_train(self)
  end

  def stop?
    @speed.zero?
  end
end
