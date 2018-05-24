class TrainFactory
  def self.build(args)
    puts 'Поезд успешно добавлен'
    args[:type].new(args[:number])
  end
end