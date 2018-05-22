class Train
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
    if @route.nil?
      puts 'Сначала выберите маршрут'
    elsif @current_station_id >= @route.stations.size - 1
      puts 'Конечная станция. Конец маршрута.'
    else
      remove_from_current_station
      @current_station_id += 1
      puts "Едем в #{@route.stations[@current_station_id].name}"
      add_to_current_station
    end
  end

  def go_previous_station
    if @route.nil?
      puts 'Сначала выберите маршрут'
    elsif @current_station_id.zero?
      puts 'Конечная станция. Конец маршрута.'
    else
      remove_from_current_station
      @current_station_id -= 1
      puts "Едем в #{@route.stations[@current_station_id].name}"
      add_to_current_station
      end
  end

  def near_stations
    if @route.nil?
      puts 'Сначала выберите маршрут'
    else
      previous_station = if @current_station_id.zero?
                           'Поезд на конечной станции'
                         else
                           @route.stations[@current_station_id - 1].name
                         end
      next_station = if @current_station_id <= @route.stations.size - 2
                       @route.stations[@current_station_id + 1].name
                     else
                       'Поезд на конечной станции'
                     end
      puts 'Предыдущая станция:' + previous_station.to_s
      puts 'Следующая станция:' + next_station.to_s
      end
  end

  def add_route(route)
    remove_from_current_station unless @route.nil?
    @current_station_id = 0
    @route = route
    add_to_current_station
  end

  # def add_wagon(wagon)
  #   if stop?
  #     COMPARABLE_WAGONS_TYPES.include?(wagon.class) ? @wagons << wagon : 'Неверный тип вагона'
  #     current_wagons
  #   else
  #     puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
  #   end
  # end

  def remove_wagon
    if stop?
      @wagons.delete_at(-1)
      current_wagons
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end

  private # Используется только внутри класса

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
