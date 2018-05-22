require_relative 'passenger_wagon'
class PassengerTrain < Train
  COMPARABLE_WAGONS_TYPES = [PassengerWagon].freeze
end