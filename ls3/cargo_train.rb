require_relative 'cargo_wagon'
class CargoTrain < Train
  COMPARABLE_WAGONS_TYPES = [CargoWagon].freeze

  def add_wagon(wagon)
    if stop?
      if COMPARABLE_WAGONS_TYPES.include?(wagon.class)
        @wagons << wagon
      else
        puts 'Неверный тип вагона'
      end
      current_wagons
    else
      puts 'Цеплять или отцеплять вагоны можно только при полной остановке'
    end
  end
end
