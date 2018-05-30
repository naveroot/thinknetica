module StationGUI

  def selected_station_info
    puts 'Выбраная станция: ' + @selected_station.name
    puts 'Число поездов на станции: ' + @selected_station.trains.size.to_s
    puts 'Из них пассажирских: ' + @selected_station.trains.select {|train| train.is_a? PassengerTrain}.size.to_s
    puts 'Из них грузовых: ' + @selected_station.trains.select {|train| train.is_a? CargoTrain}.size.to_s
    puts 'Список поездов: ' + @selected_station.trains.map(&:number).join(' ')
  end

  def stations_menu_choice
    puts '======================== '
    puts 'Меню управления станциями'
    puts '======================== '
    selected_station_info unless @station_select_id.nil?
    puts 'Выберите действие:'
    puts '0. Выбрать станцию'
    puts '1. Создать станцию'
    unless @station_select_id.nil?
      puts '2. Добавить поезд на станцию'
      puts '3. Удалить поезд со станции'
    end
    puts '9. Выход в главное меню'
    gets.chomp.to_i
  end

  def new_station
    puts '==========================='
    puts 'Создаем новую станцию'
    puts '==========================='
    puts 'Введите название станции'
    station_name = gets.chomp
    Station.new station_name
    @station_select_id = Station.all.size - 1
    @selected_station = Station.all.last
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def select_station
    raise 'В списке нет ниодной станции' if Station.all.empty?
    puts 'Список всех станций: '
    Station.all.each_with_index {|station, index| puts "[#{index}] #{station.name}"}
    choice = gets.chomp.to_i
    raise 'Введите корректный номер станции' unless choice.between?(0, Station.all.size - 1)
    @station_select_id = choice
    @selected_station = Station.all[@station_select_id]
  end

  def add_train_to_station
    raise 'Все имеющиеся поезда на станции' if (Train.all - @selected_station.trains).empty?
    raise 'В системе нет ниодного поезда' if Train.all.empty?
    puts 'Выберите поезд для добавления: '
    Train.all.each_with_index do |train, index|
      puts "#{index}: #{train.number}"
    end
    choice = gets.chomp.to_i
    raise 'Введите корректный номер поезда' unless choice.between?(0, Train.all.size - 1)
    @selected_station.add_train(Train.all[choice])
  rescue RuntimeError => error
    puts error.message
  end

  def remove_train_from_station
    raise 'На станции нет поездов' if @selected_station.trains.empty?
    puts 'Выберите поезд для удаления: '
    @selected_station.trains.each_with_index do |train, index|
      puts "#{index}: #{train.number}"
    end
    choice = gets.chomp.to_i
    raise 'Введите корректный номер поезда' unless choice.between?(0, @selected_station.trains.size - 1)
    @selected_station.remove_train(@selected_station.trains[choice])
  rescue RuntimeError => error
    puts error.message
  end
end