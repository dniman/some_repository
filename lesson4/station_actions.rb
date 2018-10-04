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
      if App.stations.length > 0
        puts "Выберите станцию из списка: "
        nums = []
        App.stations.each_with_index do |station, index|
          nums << index + 1
          puts "  #{index + 1}.#{station.name}"
        end
        print "#{nums.join("/")}: "
        num = gets.chomp.to_i
        puts "Список поездов на станции: #{App.stations[num - 1].trains.length}"
        App.stations[num - 1].trains.each do |train|
          puts "  Поезд №#{train.number} - #{train.type}"
        end
      else
        puts "Список доступных станций: #{App.stations.length}"
      end
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

end