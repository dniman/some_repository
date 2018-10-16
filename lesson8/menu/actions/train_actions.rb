# frozen_string_literal: true

class Menu
  module Actions
    module TrainActions
      def create_train_action
        lambda do
          begin
            print 'Введите номер поезда: '
            number = gets.chomp
            print 'Введите тип поезда (1-пассажирский/2-грузовой): '
            type = gets.chomp.to_i
            App.create_train(number, type)
            puts 'Добавлен поезд  '\
            "#{App.trains.last.number} - #{App.trains.last.type}"
          rescue StandardError => e
            puts e.message
            retry
          end
        end
      end

      def show_trains_action
        lambda do
          puts "Список доступных поездов: #{App.trains.length}"
          App.trains.each do |train|
            puts "  #{train.number} - #{train.type}"
          end
        end
      end

      def add_carriage_to_train_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]
          if train.is_a?(PassengerTrain)
            puts 'Введите общее количество мест в вагоне: '
            seats_count = gets.chomp.to_i
            train.add_carriage(PassengerCarriage.new(seats_count))
          else
            puts 'Введите общий объем вагона: '
            capacity = gets.chomp.to_i
            train.add_carriage(CargoCarriage.new(capacity))
          end
        end
      end

      def delete_carriage_from_train_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]
          train.delete_carriage
        end
      end

      def show_train_carriages_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]
          puts "Количество доступных вагонов: #{train.carriages.length}"
          train.each_carriage { |carriage| puts carriage }
        end
      end

      def set_route_to_train_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end
          if App.routes.empty?
            raise 'Список доступных маршрутов: '\
            "#{App.routes.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]
          route_num = select_route_from_list
          train.route = App.routes[route_num - 1]
        end
      end

      def move_train_ahead_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]
          train.move_forward
        end
      end

      def move_train_back_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]
          train.move_back
        end
      end

      def book_seat_allocate_capacity_action
        lambda do
          if App.trains.empty?
            raise 'Список доступных поездов: '\
            "#{App.trains.length}"
          end

          num = select_train_from_list
          train = App.trains[num - 1]

          if train.carriages.empty?
            raise 'Список доступных вагонов: '\
            "#{train.carriages.length}"
          end

          current_carriage = train.carriages.last
          if current_carriage.is_a?(PassengerCarriage)
            book_a_seat
          else
            allocate_capacity
          end
        end
      end

      private

      def book_a_seat
        print 'Введите номер места: '
        seat = gets.chomp.to_i
        current_carriage.book_a_seat(seat)
      rescue StandardError => e
        puts e.message.to_s
        retry
      end

      def allocate_capacity
        print 'Введите занимаемый объем: '
        capacity = gets.chomp.to_i
        current_carriage.allocate(capacity)
      rescue StandardError => e
        puts e.message.to_s
        retry
      end

      def select_train_from_list
        puts 'Выберите поезд из списка: '
        App.trains.each.with_index(1) do |train, index|
          puts "  #{index}. Поезд №#{train.number} - #{train.type}"
        end
        print "#{(1..App.trains.length).to_a.join('/')}: "
        gets.chomp.to_i
      end
    end
  end
end
