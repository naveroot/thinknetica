class CargoTrain < Train
  def initialize(number, route, type = 'CARGO')
    super(number, route, type)
  end
end