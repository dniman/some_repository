# frozen_string_literal: true

class Menu
  module Actions
    module StationActions
      def create_station_action
        lambda do
          begin
            print 'Введите наименование станции: '
            name = gets.chomp
            App.create_station(name)
          rescue StandardError => e
            puts e.message
            retry
          end
        end
      end

      def show_stations_action
        lambda do
          print_available_stations
        end
      end

      def show_station_trains_action
        lambda do
          if App.stations.empty?
            raise 'Список доступных станций: '\
            "#{App.stations.length}"
          end

          num = select_station_from_list
          print_train_list_on_station(num)
        end
      end

      private

      def print_available_stations
        puts "Список доступных станций: #{App.stations.length}"
        App.stations.each do |station|
          puts "  #{station.name}"
        end
      end

      def print_train_list_on_station(num)
        puts 'Список поездов на станции: '\
        "#{App.stations[num - 1].trains.length}"
        App.stations[num - 1].each_train do |train|
          puts "  Поезд №#{train.number} - #{train.type}"
        end
      end

      def select_station_from_list
        puts 'Выберите станцию из списка: '
        App.stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print "#{(1..App.stations.length).to_a.join('/')}: "
        gets.chomp.to_i
      end
    end
  end
end
