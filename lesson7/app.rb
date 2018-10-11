require './station'
require './route'
require './passenger_train'
require './cargo_train'
require './menu'
require './station_actions'
require './train_actions'
require './route_actions'

class App
  include StationActions
  include TrainActions
  include RouteActions

  @@stations = []
  @@trains = []
  @@routes = []
  
  class << self
    PASSENGER_TRAIN = 1
    CARGO_TRAIN = 2

    def create_station(name)
      stations << Station.new(name)
    end
  
    def stations
      @@stations
    end
  
    def get_station_by_name(name)
      stations.detect{|station| station.name == name }
    end

    def create_train(number, type)
      trains << PassengerTrain.new(number) if type == PASSENGER_TRAIN
      trains << CargoTrain.new(number) if type == CARGO_TRAIN
    end
  
    def trains
      @@trains
    end
  
    def create_route(initial_index, finite_index)
      routes << Route.new(stations[initial_index], stations[finite_index])
    end
  
    def routes
      @@routes
    end
  end

  attr_accessor :section

  def start(menu)
    clear_screen
    loop do
      menu.show
      section = menu.get_section
      menu.select_action(section)
      clear_screen
    end 
  end

  def main_menu
    @main_menu ||= Menu.new.tap do |m|
      m.header = "Выберите раздел из списка: "
      m.sections << "  1. Раздел станции"
      m.sections << "  2. Раздел поезда"
      m.sections << "  3. Раздел маршруты"
      m.sections << "  4. Выйти"
      m.footer = "1/2/3/4: "
      m.actions << station_actions
      m.actions << train_actions
      m.actions << route_actions
      m.actions << exit_action
    end
  end

  def stations_menu
    @stations_menu ||= Menu.new.tap do |s|
      s.header = "Выберите действие: "
      s.sections << "  1. Создать станцию"
      s.sections << "  2. Просмотреть список доступных станций"
      s.sections << "  3. Просмотреть список поездов на станции"
      s.sections << "  4. Вернуться в предыдущее меню"
      s.footer =  "1/2/3/4: "
      s.actions << create_station_action
      s.actions << show_stations_action
      s.actions << show_station_trains_action
      s.actions << exit_action
    end
  end

  def trains_menu
    @trains_menu ||= Menu.new.tap do |t|
      t.header = "Выберите действие: "
      t.sections << "  1. Создать поезд"
      t.sections << "  2. Просмотреть список доступных поездов"
      t.sections << "  3. Добавить вагоны к поезду"
      t.sections << "  4. Отцепить вагоны от поезда"
      t.sections << "  5. Просмотреть список вагонов поезда"
      t.sections << "  6. Просмотреть список маршрутов"
      t.sections << "  7. Назначить маршрут поезду"
      t.sections << "  8. Переместить поезд по маршруту вперед"
      t.sections << "  9. Переместить поезд по маршруту назад"
      t.sections << "  10. Занять место/зарезервировать объем в поезде"
      t.sections << "  11. Вернуться в предыдущее меню"
      t.footer = "1/2/3/4/5/6/7/8/9/10/11: "
      t.actions << create_train_action
      t.actions << show_trains_action
      t.actions << add_carriage_to_train_action
      t.actions << delete_carriage_from_train_action
      t.actions << show_train_carriages_action
      t.actions << show_routes_action
      t.actions << set_route_to_train_action
      t.actions << move_train_ahead_action
      t.actions << move_train_back_action
      t.actions << book_seat_allocate_capacity_action
      t.actions << exit_action
    end
  end

  def routes_menu
    @routes_menu ||= Menu.new.tap do |r|
      r.header = "Выберите действие: "
      r.sections << "  1. Создать маршрут"
      r.sections << "  2. Просмотреть список доступных станций"
      r.sections << "  3. Просмотреть список маршрутов"
      r.sections << "  4. Добавить промежуточную станцию в маршрут"
      r.sections << "  5. Удалить промежуточную станцию с маршрута"
      r.sections << "  6. Вернуться в предыдущее меню"
      r.footer = "1/2/3/4/5/6: "
      r.actions << create_route_action
      r.actions << show_stations_action
      r.actions << show_routes_action
      r.actions << add_intermediate_station_to_route_action
      r.actions << delete_intermediate_station_from_route_action
      r.actions << exit_action
    end
  end

  private
  def station_actions
    lambda do 
      App.new.tap do |a|
        a.start(a.stations_menu) 
      end
    end
  end

  def train_actions
    lambda do
      App.new.tap do |a|
        a.start(a.trains_menu)
      end
    end
  end

  def route_actions
    lambda do
      App.new.tap do |a|
        a.start(a.routes_menu)
      end
    end
  end

  def exit_action
    lambda { raise StopIteration }
  end

  def clear_screen
    system("clear")
  end
end
