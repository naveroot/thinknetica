require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'interface_gui'
require_relative 'route_gui'
require_relative 'train_gui'
require_relative 'station_gui'
require_relative 'vendor_info'
require_relative 'instance_counter'
class LessonOOP
  include InterfaceGUI

  def seed
    CargoTrain.new 'ASDFG'
    PassengerTrain.new '12345'
    Station.new 'Asd'
    Station.new 'Sdf'
    Station.new 'GHj'
  end
  def start
    seed
    main_menu
  end

  private #не должнобыть доступно извне

  def main_menu
    loop do
      case main_menu_choice
      when 1
        stations_menu
      when 2
        route_menu
      when 3
        train_menu
      when 9
        break
      else
        enter_correct_choice
      end
    end
  end

  def train_menu
    loop do
      case trains_menu_choice
      when 0
        select_train
      when 1
        new_train
      when 2
        Train.all[@train_select_id].speed_up
      when 3
        Train.all[@train_select_id].stop
      when 4
        Train.all[@train_select_id].add_wagon(Train.all[@train_select_id].is_a?(CargoTrain) ? CargoWagon.new : PassengerWagon.new)
      when 5
        Train.all[@train_select_id].remove_wagon
      when 6
        select_route
        Train.all[@train_select_id].add_route(Route.all[@route_select_id])
      when 7
        Train.all[@train_select_id].go_next_station
      when 8
        Train.all[@train_select_id].go_previous_station
      when 9
        Train.all[@train_select_id].near_stations
      when 10
        break
      else
        enter_correct_choice
      end
      press_any_key
    end
  rescue RuntimeError => error
    puts error.message
    press_any_key
    retry
  end

  def route_menu
    loop do
      case routes_menu_choice
      when 1
        new_route
      when 2
        add_station_to_route
      when 3
        remove_station_from_route
      when 9
        break
      else
        enter_correct_choice
      end
    end
  rescue RuntimeError => error
    puts error.message
    press_any_key
    retry
  end

  def stations_menu
    loop do
      case stations_menu_choice
      when 0
        select_station
      when 1
        new_station
      when 2
        add_train_to_station
      when 3
        remove_train_from_station
      when 9
        break
      else
        enter_correct_choice
      end
    end
  rescue RuntimeError => error
    puts error.message
    press_any_key
    retry
  end

  def press_any_key
    puts 'press any key...'
    gets
  end
end

lesson = LessonOOP.new
lesson.start
