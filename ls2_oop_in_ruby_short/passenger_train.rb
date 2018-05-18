class PassengerTrain < Train
  def initialize(number, route, type = 'PASSENGER')
    super(number, route, type)
  end
end