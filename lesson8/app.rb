# frozen_string_literal: true

require './station'
require './route'
require './passenger_train'
require './cargo_train'
require './menu/main_menu'
require './menu/stations_menu'
require './menu/trains_menu'
require './menu/stations_menu'
require './menu/routes_menu'

#
# Класс приложения
#
class App
  include Menu::MainMenu
  include Menu::StationsMenu
  include Menu::TrainsMenu
  include Menu::RoutesMenu

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
      stations.detect { |station| station.name == name }
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
    loop do
      begin
        menu.activate!
      rescue StopIteration
        clear_screen
        break
      rescue StandardError => e
        puts e.message.to_s
      end
    end
  end

  private

  def clear_screen
    system('clear')
  end
end
