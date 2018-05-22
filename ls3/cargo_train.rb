require_relative 'cargo_wagon'
class CargoTrain < Train
  COMPARABLE_WAGONS_TYPES = [CargoWagon].freeze
end