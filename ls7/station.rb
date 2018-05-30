require_relative 'instance_counter'
class Station
  include InstanceCounter
  @@stations = []
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    instances_counter_up
  end

  def self.all
    @@stations
  end

  def each_train_on_station(&block)
    raise 'Нужно передать блок' unless block_given?
    @trains.each {|train| yield(train)}
  end

  def add_train(train)
    raise 'train must be Train' unless train.is_a? Train
    raise 'Этот поезд уже есть на станции' if @trains.include? train
    @trains << train
  end

  def remove_train(train)
    raise 'train must be Train' unless train.is_a? Train
    raise 'Этого поезда нет на станции' unless @trains.include? train
    @trains.delete(train)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'name должно быть строкой' unless name.is_a? String
    raise 'Название не может быть пустым' if name == ''
    raise 'Станция с таким названием уже создана' if @@stations.map(&:name).include?(name)
    true
  end
end
