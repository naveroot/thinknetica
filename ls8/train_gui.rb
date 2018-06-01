module TrainGUI
  TRAIN_TYPE = [CargoTrain, PassengerTrain].freeze

  def select_train_type
    puts 'Выберите тип поезда:'
    TRAIN_TYPE.each_with_index { |type, index| puts "[#{index}] #{type}" }
    choice = protected_prompt(TRAIN_TYPE.size)
    TRAIN_TYPE[choice]
  end

  def new_train
    puts "Создаем новый поезд \nНомер поезда имеет формат ХХХ-ХХ или ХХХХХ"
    puts 'Введите номер поезда:'
    number = gets.chomp.upcase
    select_train_type.new number
    @train_select_id = Train.all.size - 1
    @selected_train = Train.all[@train_select_id]
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def select_train
    raise 'В списке нет поездов' if Train.all.empty?
    puts 'Список всех поездов: '
    Train.all.each_with_index do |train, index|
      puts "[#{index}] #{train.class} #{train.number} "
    end
    @train_select_id = protected_prompt(Train.all.size)
    @selected_train = Train.all[@train_select_id]
  end

  def show_previous_station
    near_stations = @selected_train.near_stations
    puts 'предыдущая станция: ' + if near_stations[:previous_station].nil?
                                    'Конечная'
                                  else
                                    near_stations[:previous_station].name
                                  end
  end

  def show_next_station
    near_stations = @selected_train.near_stations
    puts 'следующая станция: ' + if near_stations[:next_station].nil?
                                   'Конечная'
                                 else
                                   near_stations[:next_station].name
                                 end
  end

  def main_train_info
    puts 'номер: ' + @selected_train.number.to_s
    puts 'скорость: ' + @selected_train.speed.to_s
    puts 'число вагонов: ' + @selected_train.wagons.size.to_s
  end

  def selected_train_info
    puts 'Выбраный поезд:'
    main_train_info
    show_next_station
    show_previous_station
    puts 'текущая станция: ' + @selected_train.current_station.name
    puts '========================='
  rescue RuntimeError => error
    puts error.message
  end

  def menu1
    puts '0. Выбрать поезд'
    puts '1. Создать поезд'
  end

  def menu2
    puts '2. Набрать скорость'
    puts '3. Остановить поезд'
    puts '4. Прицепить вагон'
    puts '5. Отцепить вагон'
    puts '6. Добавить маршрут следования'
    puts '7. Посмотреть список вагонов поезда'
    puts '8. Занять место в вагоне'
  end

  def menu3
    puts '9. Ехать к следующей станции'
    puts '10. Ехать к предыдущей станции'
    puts '11. Посмотреть соседние станции'
  end

  def trains_menu_choice
    puts 'Меню управления поездами'
    selected_train_info unless @selected_train.nil?
    puts 'Выберите действие: '
    menu1
    unless @selected_train.nil?
      menu2
      menu3 unless @selected_train.route.nil?
    end
    puts '100.Выход в главное меню'
    gets.chomp.to_i
  end
end
