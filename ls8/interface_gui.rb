require_relative 'train_gui'
require_relative 'station_gui'
require_relative 'route_gui'
require_relative 'wagon_gui'
module InterfaceGUI
  def self.included(base_class)
    base_class.send :include, TrainGUI
    base_class.send :include, StationGUI
    base_class.send :include, RouteGUI
    base_class.send :include, WagonGui
  end

  private

  def protected_prompt(size)
    @size = size
    puts 'Выберите номер:'
    loop do
      @choice = gets.chomp.to_i
      break if @choice.between?(0, @size - 1)
      puts "неверный номер. выберите номер от 0 до  #{@size - 1}"
    end
    @choice
  end

  def enter_correct_choice
    puts 'Введите корректное число!'
  end

  def main_menu_choice
    puts '========================'
    puts 'Главное меню'
    puts '========================'
    puts '1. Управление станциями'
    puts '2. Управление маршрутами'
    puts '3. Управление поездами'
    puts '9. Для выхода'
    puts 'Выберите действие: '
    gets.chomp.to_i
  end
end
