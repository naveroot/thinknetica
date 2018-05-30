module TrainGUI
  TRAIN_TYPE = [CargoTrain, PassengerTrain].freeze

  def new_train
    puts '==========================='
    puts 'Создаем новый поезд'
    puts '==========================='
    puts 'Номер поезда имеет формат ХХХ-ХХ или ХХХХХ'
    puts 'Введите номер поезда:'
    number = gets.chomp.upcase
    puts 'Выберите тип поезда:'
    TRAIN_TYPE.each_with_index {|type, index| puts "[#{index}] #{type}"}
    choice = protected_prompt(TRAIN_TYPE.size)
    train_type = TRAIN_TYPE[choice]
    train_type.new number
    @train_select_id = Train.all.size - 1
    @selected_train = Train.all[@train_select_id]
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def select_train
    raise 'В списке нет поездов' if Train.all.empty?
    puts 'Список всех поездов: '
    Train.all.each_with_index {|train, index| puts "[#{index}] #{train.class} #{train.number} "}
    @train_select_id = protected_prompt(Train.all.size)
    @selected_train = Train.all[@train_select_id]
  end

  def selected_train_info
    puts 'Выбраный поезд:'
    puts '========================='
    puts 'номер: ' + @selected_train.number.to_s
    puts 'скорость: ' + @selected_train.speed.to_s
    puts 'число вагонов: ' + @selected_train.wagons.size.to_s
    near_stations = @selected_train.near_stations
    puts 'предыдущая станция: ' + if near_stations[:previous_station].nil?
                                    'Конечная'
                                  else
                                    near_stations[:previous_station].name
                                  end
    puts 'следующая станция: ' + if near_stations[:next_station].nil?
                                   'Конечная'
                                 else
                                   near_stations[:next_station].name
                                 end
    puts 'текущая станция: ' + @selected_train.current_station.name
    puts '========================='
  rescue RuntimeError => error
    puts error.message
    puts '========================='
  end

  def trains_menu_choice
    puts '========================'
    puts 'Меню управления поездами'
    puts '========================'
    selected_train_info unless @selected_train.nil?
    puts 'Выберите действие: '
    puts '0. Выбрать поезд'
    puts '1. Создать поезд'
    unless @selected_train.nil?
      puts '2. Набрать скорость'
      puts '3. Остановить поезд'
      puts '4. Прицепить вагон'
      puts '5. Отцепить вагон'
      puts '6. Добавить маршрут следования'
      puts '7. Посмотреть список вагонов поезда'
      puts '8. Занять место в вагоне'
      unless @selected_train.route.nil?
        puts '9. Ехать к следующей станции'
        puts '10. Ехать к предыдущей станции'
        puts '11. Посмотреть соседние станции'
      end
    end
    puts '100.Выход в главное меню'
    gets.chomp.to_i
  end
end