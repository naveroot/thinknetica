class Train
  attr_reader :wagons
  def initialize(args)
    args = args.merge(defaults)
    @type = args[:type]
    @wagons = args[:wagons]
    @speed = 0
    @route = []
  end

  def defaults
    { type: 'cargo', wagons: rand(10) }
  end

  def speed_up
    @speed += 10
    current_speed
  end

  def speed_down
    @speed -= 10
    current_speed
  end

  def current_speed
    puts "Скорость поезда: #{@speed}"
  end

  def current_wagons
    puts "Колличество вагонов: #{@speed}"
  end

  def add_wagon
    if stop?
      @wagons += 1
      current_wagons
    else
      puts "Цеплять или отцеплять вагоны можно только при полной остановке"
    end
  end

  def remove_wagon
    if stop?
      @wagons -= 1
      current_wagons
    else
      puts "Цеплять или отцеплять вагоны можно только при полной остановке"
    end
  end



  private

  def stop?
    @speed.zero?
  end
end