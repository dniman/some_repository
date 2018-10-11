module StationActions

  def create_station_action
    lambda do
      begin
        print "Введите наименование станции: "
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
      puts "Список доступных станций: #{App.stations.length}"
      App.stations.each do |station|
        puts "  #{station.name}"
      end
      print "Нажмите Enter для продолжения..."
      gets
    end
  end

  def show_station_trains_action
    lambda do
      if App.stations.length > 0
        puts "Выберите станцию из списка: "
        App.stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print "#{(1..App.stations.length).to_a.join("/")}: "
        num = gets.chomp.to_i
        puts "Список поездов на станции: #{App.stations[num - 1].trains.length}"
        App.stations[num - 1].each_train do |train|
          puts "  Поезд №#{train.number} - #{train.type}"
        end
      else
        puts "Список доступных станций: #{App.stations.length}"
      end
      print "Нажмите Enter для продолжения..."
      gets
    end
  end

end
