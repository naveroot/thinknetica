require_relative 'cargo_wagon'
require_relative 'accessors'
require_relative 'validation'
class CargoTrain < Train
  extend Accessors
  include Validation
  validate :number, :format, REGEXP_VALIDATE
  validate :number, :type, String
  validate :number, :presence

  def initialize(name)
    @type = :cargo
    super(name)
  end

  protected

  # def validate!
  #   raise 'Тип поезда не соответствует классу' if type != :cargo
  #   super
  # end
end
