module StationActions

  def create_station_action
    lambda do
      print "Введите наименование станции: "
      name = gets.chomp
      App.create_station(name) 
    end
  end

  def show_stations_action
    lambda do
      puts "Список доступных станций: #{App.stations.length}"
      App.stations.each do |station|
        puts "  #{station.name}"
      end
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

  def show_station_trains_action
    lambda do
      print "Введите наименование станции: "
      name = gets.chomp
      puts "Список поездов на станции: #{App.available_trains(name).length}"
      App.available_trains(name).each do |train|
        puts "  №#{train.number} - #{train.type}"
      end
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

end