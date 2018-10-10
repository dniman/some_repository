module TrainActions

  def create_train_action
    lambda do
      begin
        print "Введите номер поезда: "
        number = gets.chomp
        print "Введите тип поезда (1-пассажирский/2-грузовой): "
        type = gets.chomp.to_i
        App.create_train(number, type)
        puts "Добавлен поезд  #{App.trains.last.number} - #{App.trains.last.type}"
        print "Нажмите Enter для продолжения..."
        gets  
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
      print "Нажмите Enter для продолжения..."
      gets
    end
  end

  def add_carriage_to_train_action
    lambda do
      if App.trains.empty?
        puts "Список доступных поездов: #{App.trains.length}"
        print "Нажмите Enter для продолжения..."
        gets
        return
      end
      puts "Выберите поезд из списка: "
      App.trains.each.with_index(1) do |train, index|
        puts "  #{index}. Поезд №#{train.number} - #{train.type}"
      end
      print "#{(1..App.trains.length).to_a.join("/")}: "
      num = gets.chomp.to_i
      train = App.trains[num - 1]
      if train.is_a?(PassengerTrain)
        train.add_carriage(PassengerCarriage.new)
      else
        train.add_carriage(CargoCarriage.new)
      end
    end
  end

  def delete_carriage_from_train_action
    lambda do
      if App.trains.empty?
        puts "Список доступных поездов: #{App.trains.length}"
        print "Нажмите Enter для продолжения..."
        gets
        return
      end
      puts "Выберите поезд из списка: "
      App.trains.each.with_index(1) do |train, index|
        puts "  #{index}. Поезд №#{train.number} - #{train.type}"
      end
      print "#{(1..App.trains.length).to_a.join("/")}: "
      num = gets.chomp.to_i
      train = App.trains[num - 1]
      train.delete_carriage
    end
  end

  def show_train_carriages_action
    lambda do
      unless App.trains.empty?
        puts "Выберите поезд из списка: "
        App.trains.each.with_index(1) do |train, index|
          puts "  #{index}. Поезд №#{train.number} - #{train.type}"
        end
        print "#{(1..App.trains.length).to_a.join("/")}: "
        num = gets.chomp.to_i
        train = App.trains[num - 1]
        puts "Количество доступных вагонов: #{train.carriages.length}"
      else
        puts "Список доступных поездов: #{App.trains.length}"
      end
      print "Нажмите Enter для продолжения..."
      gets
    end
  end

  def set_route_to_train_action
    lambda do
      if App.trains.empty?
        puts "Список доступных поездов: #{App.trains.length}"
        print "Нажмите любую клавишу для продолжения..."
        gets
        return
      end
      if App.routes.empty?
        puts "Список доступных маршрутов: #{App.routes.length}"
        print "Нажмите Enter для продолжения..."
        gets
        return
      end
      puts "Выберите поезд из списка: "
      App.trains.each.with_index(1) do |train, index|
        puts "  #{index}. Поезд №#{train.number} - #{train.type}"
      end
      print "#{(1..App.trains.length).to_a.join("/")}: "
      num = gets.chomp.to_i
      train = App.trains[num - 1]

      puts "Выберите маршрут из списка: "
      App.routes.each.with_index(1) do |route,index|
        station_names = route.stations.map{|station| station.name}
        puts "  #{index}.#{station_names.join('-')}"
      end
      print "#{(1..App.routes.length).to_a.join("/")}: "
      route_num = gets.chomp.to_i  
      train.route = App.routes[route_num - 1]
    end
  end

  def move_train_ahead_action
    lambda do
      if App.trains.empty?
        puts "Список доступных поездов: #{App.trains.length}"
        print "Нажмите Enter для продолжения..."
        gets
        return
      end
      puts "Выберите поезд из списка: "
      App.trains.each.with_index(1) do |train, index|
        puts "  #{index}. Поезд №#{train.number} - #{train.type}"
      end
      print "#{(1..App.trains.length).to_a.join("/")}: "
      num = gets.chomp.to_i
      train = App.trains[num - 1]
      train.move_forward
    end
  end

  def move_train_back_action
    lambda do
      if App.trains.empty?
        puts "Список доступных поездов: #{App.trains.length}"
        print "Нажмите Enter для продолжения..."
        gets
        return
      end
      puts "Выберите поезд из списка: "
      App.trains.each.with_index(1) do |train, index|
        puts "  #{index}. Поезд №#{train.number} - #{train.type}"
      end
      print "#{(1..App.trains.length).to_a.join("/")}: "
      num = gets.chomp.to_i
      train = App.trains[num - 1]
      train.move_back      
    end
  end
end
