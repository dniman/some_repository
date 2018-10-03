module TrainActions

  def create_train_action
    lambda do
      print "Введите номер поезда: "
      number = gets.chomp
      print "Введите тип поезда (1-пассажирский/2-грузовой): "
      type = gets.chomp.to_i
      App.create_train(number, type)
    end
  end

  def show_trains_action
    lambda do
      puts "Список доступных поездов: #{App.trains.length}"
      App.trains.each do |train|
        puts "  #{train.number} - #{train.type}"
      end
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

  def add_carriage_to_train_action
    lambda do
      print "Введите номер поезда: "
      number = gets.chomp
      print "Введите тип поезда (1-пассажирский/2-грузовой): "
      type = gets.chomp.to_i

      train_klass = App.passenger_train?(type) ? PassengerTrain : CargoTrain
      train = App.trains.select do |tr| 
        tr.number.eql?(number) && tr.is_a?(train_klass)
      end.first
      carriage_klass = type.eql?(1) ? PassengerCarriage : CargoCarriage
      train.add_carriage(carriage_klass.new) 
    end
  end

  def delete_carriage_from_train_action
    lambda do
      print "Введите номер поезда: "
      number = gets.chomp
      print "Введите тип поезда (1-пассажирский/2-грузовой): "
      type = gets.chomp.to_i

      train_klass = App.passenger_train?(type) ? PassengerTrain : CargoTrain
      train = App.trains.select do |tr| 
        tr.number.eql?(number) && tr.is_a?(train_klass)
      end.first
      train.delete_carriage if train
    end
  end

  def show_train_carriages_action
    lambda do
      print "Введите номер поезда: "
      number = gets.chomp
      print "Введите тип поезда (1-пассажирский/2-грузовой): "
      type = gets.chomp.to_i

      train_klass = App.passenger_train?(type) ? PassengerTrain : CargoTrain
      train = App.trains.select do |tr| 
        tr.number.eql?(number) && tr.is_a?(train_klass)
      end.first
      
      puts "Список доступных вагонов: #{train.carriages.length}" if train
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

  def set_route_to_train_action
    lambda do
    end
  end

  def move_train_ahead_action
    lambda do
    end
  end

  def move_train_back_action
    lambda do
    end
  end
end