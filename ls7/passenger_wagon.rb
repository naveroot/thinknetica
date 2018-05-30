class PassengerWagon < Wagon
  attr_reader :type, :occupied_seats, :seats, :name

  def initialize(name, seats)
    @name = name
    @type = :passenger
    @seats = seats
    @occupied_seats = 0
    validate!
  end

  def take_place
    raise 'Все места заняты' if @seats == @occupied_seats
    @occupied_seats += 1
  end

  def available_seats
    @seats - @occupied_seats
  end

  protected

  def validate!
    raise 'колличество должно быть числом' unless seats.is_a? Float
    raise 'колличество мест должно быть больше нуля' if seats < 0
    raise 'Тип вагона не соответствует классу' if type != :passenger
    true
  end
end
