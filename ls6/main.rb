require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'interface_gui'


class LessonOOP
  include InterfaceGUI

  def start
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
    trains_list
    loop do
      case trains_menu_choice
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
        routes_list
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
    end
  end

  def route_menu
    routes_list
    loop do
      case routes_menu_choice
      when 1
        new_route
      when 2
        puts 'Выберите станцию для добавления:'
        station_list
        Route.all[@route_select_id].add_station(Station.all[@station_select_id])
      when 3
        Route.all[@route_select_id].remove_station
      when 4
        Route.all[@route_select_id].all_station_list
      when 9
        break
      else
        enter_correct_choice
      end

    end
  end

  def stations_menu
    station_list
    loop do
      case stations_menu_choice
      when 1
        new_station
      when 2
        trains_list
        Station.all[@station_select_id].add_train(Train.all[@train_select_id])
      when 3
        Station.all[@station_select_id].show_trains
      when 4
        Station.all[@station_select_id].show_train_types
      when 5
        Station.all[@station_select_id].show_remove_train
      when 6
        station_list
      when 9
        break
      else
        enter_correct_choice
      end
    end
  end
end

lesson = LessonOOP.new
lesson.start
