# frozen_string_literal: true

class Menu
  module Actions
    #
    # Экшены по разделу маршруты
    #
    module RouteActions
      def create_route_action
        lambda do
          if App.stations.length < 2
            raise 'Список доступных станций: '\
            "#{App.stations.length}"
          end
          initial_num = select_initial_station_from_list
          available_stations = App.stations - [App.stations[initial_num - 1]]
          finite_num = select_finite_station_from_list(available_stations,
                                                       initial_num)
          finite_index = App.stations.find_index(
            available_stations[finite_num - 1]
          )
          App.create_route(initial_num - 1, finite_index)
        end
      end

      def show_routes_action
        lambda do
          puts "Список доступных маршрутов: #{App.routes.length}"
          App.routes.each.with_index(1) do |route, index|
            station_names = route.stations.map(&:name)
            puts "  #{index}.#{station_names.join('-')}"
          end
        end
      end

      def add_intermediate_station_to_route_action
        lambda do
          if App.routes.empty?
            raise 'Список доступных маршрутов: '\
            "#{App.routes.length}"
          end
          route_num = select_route_from_list
          route = App.routes[route_num - 1]
          available_stations = App.stations - route.stations
          if available_stations.empty?
            raise 'Список доступных станций: '\
            "#{available_stations.length}"
          end
          num = select_intermediate_station_from_list(available_stations)
          station = available_stations[num - 1]
          App.routes[route_num - 1].add_station(station)
        end
      end

      def delete_intermediate_station_from_route_action
        lambda do
          if App.routes.empty?
            raise 'Список доступных маршрутов: '\
            "#{App.routes.length}"
          end

          route_num = select_route_from_list
          route = App.routes[route_num - 1]

          available_stations = route.stations -
                               [route.stations.first, route.stations.last]
          if available_stations.empty?
            raise 'Список доступных станций: '\
            "#{available_stations.length}"
          end

          num = select_intermediate_station_from_list(available_stations)

          station = available_stations[num - 1]
          App.routes[route_num - 1].delete_station(station)
        end
      end

      private

      def select_route_from_list
        puts 'Выберите маршрут из списка: '
        App.routes.each.with_index(1) do |route, index|
          station_names = route.stations.map(&:name)
          puts "  #{index}.#{station_names.join('-')}"
        end
        print "#{(1..App.routes.length).to_a.join('/')}: "
        gets.chomp.to_i
      end

      def select_intermediate_station_from_list(stations)
        print 'Выберите промежуточную станцию из списка: '
        stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print "#{(1..stations.length).to_a.join('/')}: "
        gets.chomp.to_i
      end

      def select_initial_station_from_list
        puts 'Выберите начальную станцию из списка: '
        App.stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print "#{(1..App.stations.length).to_a.join('/')}: "
        gets.chomp.to_i
      end

      def select_finite_station_from_list(available_stations, _initial_num)
        puts 'Выберите конечную станцию из списка: '
        available_stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print "#{(1..available_stations.length).to_a.join('/')}: "
        gets.chomp.to_i
      end
    end
  end
end
