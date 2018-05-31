module WagonGui
  def new_wagon(train)
    create_cargo_wagon(train) if train.is_a? CargoTrain
    create_passenger_wagon(train) if train.is_a? PassengerTrain
  end

  def select_wagon(wagons)
    wagons.each_with_index do |wagon, index|
      puts "#{index}: #{wagon.name} #{wagon.type}"
    end
    choice = gets.chomp.to_i
    raise 'Введите корректный номер вагона' unless choice.between?(0, wagons.size - 1)
    wagons[choice]
  end

  def create_cargo_wagon(train)
    wagon_name = train.number + '-' + train.wagons.size.to_s
    puts 'Введите объем вагона:'
    volume = gets.chomp.to_f
    train.add_wagon(CargoWagon.new(wagon_name, volume))
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def create_passenger_wagon(train)
    wagon_name = train.number + '-' + train.wagons.size.to_s
    puts 'Введите число мест:'
    seats = gets.chomp.to_f
    train.add_wagon(PassengerWagon.new(wagon_name, seats))
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def add_to_wagon(wagons)
    wagon = select_wagon(wagons)
    if wagon.is_a? CargoWagon
      puts 'Введите объем:'
      volume = gets.chomp.to_f
      wagon.occupy_volume(volume)
    elsif wagon.is_a? PassengerWagon
      wagon.take_place
    else
      raise 'wagon has wrong type'
    end
  end

  def show_all_wagons(train)
    if train.is_a? CargoTrain
      train.each_wagon_in_train do |wagon|
        puts "#{wagon.name} #{wagon.type} занято:#{wagon.occupied_volume} свободно:#{wagon.available_volume}"
      end
    else
      train.each_wagon_in_train do |wagon|
        puts "#{wagon.name} #{wagon.type} занято:#{wagon.occupied_seats} свободно:#{wagon.available_seats}"
      end
    end
  end
end

