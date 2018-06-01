module StationGUI
  def station_name_info
    puts 'Выбраная станция: ' + @selected_station.name
  end

  def station_trains_info
    puts 'Число поездов на станции: ' + @selected_station.trains.size.to_s
  end

  def passenger_trains_info
    pas_trains = @selected_station.trains.select { |train| train.is_a? PassengerTrain }.size.to_s
    puts 'Из них пассажирских: ' + pas_trains
  end

  def cargo_trains_info
    cargo_trains = @selected_station.trains.select do |train|
      train.is_a? CargoTrain
    end.size.to_s
    puts 'Из них грузовых: ' + cargo_trains
  end

  def trains_list_info
    puts 'Список поездов: '
    @selected_station.each_train_on_station do |train|
      puts "#{train.number} #{train.type} #{train.wagons.size}"
    end
  end

  def selected_station_info
    station_name_info
    station_trains_info
    passenger_trains_info
    cargo_trains_info
    trains_list_info
  end

  def stations_menu_choice
    puts 'Меню управления станциями'
    selected_station_info unless @station_select_id.nil?
    puts 'Выберите действие:'
    puts '0. Выбрать станцию'
    puts '1. Создать станцию'
    puts '2. Добавить поезд на станцию' unless @station_select_id.nil?
    puts '3. Удалить поезд со станции' unless @station_select_id.nil?
    puts '9. Выход в главное меню'
    gets.chomp.to_i
  end

  def new_station
    puts 'Создаем новую станцию'
    puts 'Введите название станции:'
    station_name = gets.chomp
    Station.new station_name
    @station_select_id = Station.all.size - 1
    @selected_station = Station.all.last
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def select_from_station_list
    puts 'Список всех станций: '
    Station.all.each_with_index do |station, index|
      puts "[#{index}] #{station.name}"
    end
    choice = gets.chomp.to_i
    error1 = 'Введите корректный номер станции'
    raise error1 unless choice.between?(0, Station.all.size - 1)
    choice
  end

  def select_station
    error1 = 'В списке нет ниодной станции'
    raise error1 if Station.all.empty?
    choice = select_from_station_list
    @station_select_id = choice
    @selected_station = Station.all[@station_select_id]
  end

  def validate_train_to_station
    error1 = 'Все имеющиеся поезда на станции'
    error2 = 'В системе нет ниодного поезда'
    raise error1 if (Train.all - @selected_station.trains).empty?
    raise error2 if Train.all.empty?
  end

  def select_add_train
    puts 'Выберите поезд для добавления: '
    Train.all.each_with_index { |train, index| puts "#{index}: #{train.number}" }
    choice = gets.chomp.to_i
    error1 = 'Введите корректный номер поезда'
    raise error1 unless choice.between?(0, Train.all.size - 1)
    Train.all[choice]
  end

  def add_train_to_station
    validate_train_to_station
    @selected_station.add_train(select_add_train)
  rescue RuntimeError => error
    puts error.message
  end

  def select_remove_train
    puts 'Выберите поезд для удаления: '
    @selected_station.trains.each_with_index do |train, index|
      puts "#{index}: #{train.number}"
    end
    choice = gets.chomp.to_i
    error1 = 'Введите корректный номер поезда'
    raise error1 unless choice.between?(0, @selected_station.trains.size - 1)
    @selected_station.trains[choice]
  end

  def remove_train_from_station
    error1 = 'На станции нет поездов'
    raise error1 if @selected_station.trains.empty?
    @selected_station.remove_train(select_remove_train)
  rescue RuntimeError => error
    puts error.message
  end
end
